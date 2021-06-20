#!/bin/bash

# MONTADO DE DISCO
# #######################
# SISTEMA DE ARCHIVOS
sudo apt-get install xfsprogs  >> /tmp/log.txt 2>&1
#FORMATE DE DISCO
sudo mkfs -t ext4 /dev/nvme1n1  >> /tmp/log.txt 2>&1
#MONTADO DE RUTA
mkdir /dataweb  >> /tmp/log.txt 2>&1
mount /dev/nvme1n1 /dataweb >> /tmp/log.txt 2>&1
#MONTADO AUTOMATICO DE DISCO
sudo echo -e "/dev/nvme1n1        /dataweb       ext4   defaults    0 0" >> /etc/fstab

#update 
apt-get update >> /tmp/log.txt 2>&1
#Install awscli
apt install awscli -y >> /tmp/log.txt 2>&1
#Install nginx
apt-get install nginx -y >> /tmp/log.txt 2>&1
#Install node v14
apt-get install curl -y >> /tmp/log.txt 2>&1
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - >> /tmp/log.txt 2>&1
apt-get install nodejs -y >> /tmp/log.txt 2>&1
apt-get install npm -y >> /tmp/log.txt 2>&1
npm install pm2 -g >> /tmp/log.txt 2>&1
#Ingresar a dataweb y descargar de S3 backup de aplicación
cd /dataweb/ >> /tmp/log.txt 2>&1
aws s3 cp s3://glr-infra/lsoria/backup/perucheck.tar.gz . >> /tmp/log.txt 2>&1
tar -xzvf perucheck.tar.gz >> /tmp/log.txt 2>&1


mkdir -p /var/cache/nginx/perucheck >> /tmp/log.txt 2>&1

cat <<EOF > /etc/nginx/sites-available/qa.perucheck.conf
# Cache zone
proxy_cache_path /var/cache/nginx/perucheck levels=1:2 keys_zone=STATICo:10m inactive=7d use_temp_path=off;

upstream perucheck {
#  server nextjs:3000;
  server 127.0.0.1:3000;
        keepalive 32;
}

server {
  listen 80;

  server_name testgitlabxyz2.glr.pe;

   access_log  /var/log/nginx/qa.perucheck.pe-access.log;
   error_log   /var/log/nginx/qa.perucheck.pe-error.log;
   root /dataweb/perucheck/qa.perucheck.pe;

  
server_tokens off;

  gzip on;
  gzip_proxied any;
  gzip_comp_level 4;
  gzip_types text/css application/javascript image/svg+xml;

  proxy_http_version 1.1;
  # proxy_set_header Upgrade $http_upgrade;
  # proxy_set_header Connection 'upgrade';
  # proxy_set_header Host $host;
  # proxy_cache_bypass $http_upgrade;

  # BUILT ASSETS (E.G. JS BUNDLES)
  # Browser cache - max cache headers from Next.js as build id in url
  # Server cache - valid forever (cleared after cache "inactive" period)
  location /_next/static {
#    proxy_cache STATIC;
    proxy_pass http://perucheck;
  }

  # STATIC ASSETS (E.G. IMAGES)
  # Browser cache - "no-cache" headers from Next.js as no build id in url
  # Server cache - refresh regularly in case of changes
  location /static {
 #   proxy_cache STATIC;
  #  proxy_ignore_headers Cache-Control;
  #  proxy_cache_valid 60m;
    proxy_pass http://perucheck;
  }

#    location /api-cronos/search {
#    proxy_cache STATICo;
#    #proxy_ignore_headers Cache-Control;
#   # proxy_cache_valid 60m;
#    expires 5m;
#    proxy_pass http://perucheck;
#    }

#  location /api-charbeat/live/toppages/v3 {
#    proxy_cache STATICo;
#    #proxy_ignore_headers Cache-Control;
#   # proxy_cache_valid 60m;
#    expires 5m;
#    proxy_pass http://perucheck;
#   }


#  location /grahpql {
#  #if ( $request_method ~ ^ (POST)$ ){
#   proxy_pass http://perucheck;
#  #	}
#   }

  # DYNAMIC ASSETS - NO CACHE
  location / {
    proxy_pass http://perucheck;
    #   proxy_cache_valid 200 60s;
        proxy_cache_revalidate on;
    #   expires 1m;
        proxy_cache_valid 502 503 2s;
        proxy_cache STATICo;
        proxy_ignore_headers Cache-Control Expires X-Accel-Expires Vary Set-Cookie;
    #   proxy_cache_use_stale error timeout updating http_500 http_502 http_503 http_504;
        # add_header x-cache-status $upstream_cache_status;
        # add_header x-cache-key "$host$uri";
        proxy_cache_lock on;
        proxy_cache_lock_age 5s;

  }
}
EOF



# Intalacion de varnish
apt install varnish -y  >> /tmp/log.txt 2>&1
mkdir -p /dataweb/conf/varnish/  >> /tmp/log.txt 2>&1
touch  /dataweb/conf/varnish/rules.vcl  >> /tmp/log.txt 2>&1
touch  /dataweb/conf/varnish/redirec.vcl  >> /tmp/log.txt 2>&1
touch /dataweb/conf/varnish/bad_bot_detection.vcl  >> /tmp/log.txt 2>&1

cat <<EOF > /dataweb/conf/varnish/redirec.vcl
#--------INICIO DE REQUERIMINETOS DE REDIRECCIONES

sub redirec {


if (req.url ~ "^/abcdf")
            {
                 set req.url = "/actualidad";
                 set req.http.Location = "http://abcdf-test1" + req.url;
                 return (synth(555, "Temporal moved"));
            }
}
EOF

cat <<EOF > /dataweb/conf/varnish/rules.vcl
# This is an example VCL file for Varnish.
#
# It does not do anything by default, delegating control to the
# builtin VCL. The builtin VCL is called when there is no explicit
# return statement.
#
# See the VCL chapters in the Users Guide at https://www.varnish-cache.org/docs/
# and https://www.varnish-cache.org/trac/wiki/VCLExamples for more examples.

# Marker to tell the VCL compiler that this VCL has been adapted to the
# new 4.0 format.
vcl 4.0;
import std;
include "/dataweb/conf/varnish/redirec.vcl";
#include "/dataweb/conf/varnish/bad_bot_detection.vcl";


# Default backend definition. Set this to point to your content server.
backend default {
    .host = "127.0.0.1";
    .port = "8080";
}

sub vcl_synth {
        if (resp.status == 555)
            {
                 set resp.status = 302;
                 set resp.http.location = req.http.location;
                 return(deliver);
            }

        if (resp.status == 556)
            {
                 set resp.status = 301;
                 set resp.http.location = req.http.location;
                 return(deliver);
            }
     if (resp.status == 503 && req.http.sie-enabled) {
        unset req.http.sie-enabled;
        return (restart);
    }


}

sub vcl_recv {
    # Happens before we check if we have this in cache already.
    #
    # Typically you clean up the request here, removing cookies you don't need,
    # rewriting the request, etc.
	
	if (req.method == "GET" && req.url == "/backend-status") {
       	return(synth(200, "OK"));
      }
	

	##--INVOCANDO A LA FUNCION DE REDIRECCIONES
           call redirec;
#           call bad_bot_detection;

    # Happens before we check if we have this in cache already.
    #
    # Typically you clean up the request here, removing cookies you don't need,
    # rewriting the request, etc.
  
    if (req.url ~ "\.(jpe?g|png|gif|pdf|gz|tgz|bz2|tbz|tar|zip|tiff|tif)$" || req.url ~ "/(image|(image_(?:[^/]|(?!view.*).+)))$") {
        return (hash);
    }   
    if (req.url ~ "\.(svg|swf|ico|mp3|mp4|m4a|ogg|mov|avi|wmv|flv)$") {
        return (hash);
    }   
    if (req.url ~ "\.(xls|vsd|doc|ppt|pps|vsd|doc|ppt|pps|xls|pdf|sxw|rar|odc|odb|odf|odg|odi|odp|ods|odt|sxc|sxd|sxi|sxw|dmg|torrent|deb|msi|iso|rpm)$") {
        return (hash);
    }   
    if (req.url ~ "\.(css|js)$") {
        return (hash);
    }   
    return (hash);

}

sub vcl_backend_response {

 # Happens after we have read the response headers from the backend.
      if (beresp.status >= 500 && beresp.status <= 599) {
        return (abandon);
    }
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.
    set beresp.ttl = 40s;
    set beresp.grace = 12h;
    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.
    if (beresp.ttl <= 0s ||
        beresp.http.Set-Cookie ||
        beresp.http.Vary == "*") {
        /*
         * Mark as "Hit-For-Pass" for the next 60 minutes - 24 hours
         */
        if (bereq.url ~ "\.(jpe?g|png|gif|pdf|gz|tgz|bz2|tbz|tar|zip|tiff|tif)$" || bereq.url ~ "/(image|(image_(?:[^/]|(?!view.*).+)))$") {
            set beresp.ttl = std.duration(beresp.http.age+"s",0s) + 15s;
        } elseif (bereq.url ~ "\.(svg|swf|ico|mp3|mp4|m4a|ogg|mov|avi|wmv|flv)$") {
            set beresp.ttl = std.duration(beresp.http.age+"s",0s) + 15s;
        } elseif (bereq.url ~ "\.(xls|vsd|doc|ppt|pps|vsd|doc|ppt|pps|xls|pdf|sxw|rar|odc|odb|odf|odg|odi|odp|ods|odt|sxc|sxd|sxi|sxw|dmg|torrent|deb|msi|iso|rpm)$") {
            set beresp.ttl = std.duration(beresp.http.age+"s",0s) + 15s;
        } elseif (bereq.url ~ "\.(css|js)$") {
            set beresp.ttl = std.duration(beresp.http.age+"s",0s) + 15s;
        } else {
            set beresp.ttl = std.duration(beresp.http.age+"s",0s) + 15s;
        }
    }
        return (deliver);
}

sub vcl_hit {
	     if (obj.ttl >= 0s) {
 #         // A pure unadulterated hit, deliver it
        	  return (deliver);
   	     }	
    	     if (obj.ttl + obj.grace > 0s) {
#          // Object is in grace, deliver it
#          // Automatically triggers a background fetch
             return (deliver);
             }
#          // fetch & deliver once we get the result
             return (miss);
}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.

	# Remove some headers: PHP version
        unset resp.http.X-Powered-By;

        # Remove some headers: Apache version & OS
        unset resp.http.Server;

        # Remove some heanders: Varnish
        unset resp.http.Via;
        unset resp.http.X-Varnish;

        return (deliver);
}
EOF



#quitar link simbolico "default"
rm -rf /etc/nginx/sites-enabled/default >> /tmp/log.txt 2>&1
# renobrar vhost "default"
mv /etc/nginx/sites-available/default /etc/nginx/sites-available/bk-default >> /tmp/log.txt 2>&1
#agregar link simbolico al nuevo vhost "qa.perucheck.conf"
ln -s /etc/nginx/sites-available/qa.perucheck.conf /etc/nginx/sites-enabled/qa.perucheck.conf >> /tmp/log.txt 2>&1
#validar configuracion de nginx
service nginx configtest >> /tmp/log.txt 2>&1
#reiniciar nginx
service nginx restart >> /tmp/log.txt 2>&1

##Cambiando la configuracion de varnish
#detener nginx q escucha por el 80 para que escuche por el 8080
service nginx stop >> /tmp/log.txt 2>&1
sed -i s%"listen 80;"%"listen 8080;"%g /etc/nginx/sites-available/qa.perucheck.conf  >> /tmp/log.txt 2>&1

service varnish stop >> /tmp/log.txt 2>&1
sed -i s%"-F -a :6081"%"-F -a :80"%g /lib/systemd/system/varnish.service  >> /tmp/log.txt 2>&1
sed -i s%"-T localhost:6081"%"-T localhost:6081"%g /lib/systemd/system/varnish.service  >> /tmp/log.txt 2>&1
sed -i s%"/etc/varnish/default.vcl"%"/dataweb/conf/varnish/rules.vcl"%g /lib/systemd/system/varnish.service  >> /tmp/log.txt 2>&1

systemctl daemon-reload  >> /tmp/log.txt 2>&1
service varnish restart  >> /tmp/log.txt 2>&1
service nginx restart  >> /tmp/log.txt 2>&1

##EJECUTAR APLICACION PERUCHEK
cd /dataweb/perucheck/qa.perucheck.pe >> /tmp/log.txt 2>&1
 
rm -rf node_modules >> /tmp/log.txt 2>&1
rm -rf .next >> /tmp/log.txt 2>&1
rm -rf package-lock.json >> /tmp/log.txt 2>&1

sudo pm2 delete perucheck-dev-glr  >> /tmp/log.txt 2>&1
sudo npm install --unsafe-perm  >> /tmp/log.txt 2>&1
sudo npm rebuild node-sass --unsafe-perm    >> /tmp/log.txt 2>&1
sudo npm run pm2-server-dev >> /tmp/log.txt 2>&1
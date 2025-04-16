# foswiki-container
Build first: docker build -t foswiki-image

Start: docker run --name foswiki foswiki-image -d

First run: docker exec -t foswiki /var/www/foswiki/tools/configure -save -set {Password}='adminpass'

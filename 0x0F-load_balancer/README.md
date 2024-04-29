# Load Balancer Project

## Background Context

In this project, you have been given 2 additional servers:

- `gc-[STUDENT_ID]-web-02-XXXXXXXXXX`
- `gc-[STUDENT_ID]-lb-01-XXXXXXXXXX`

The goal is to improve the web stack by adding redundancy for the web servers. This will allow the infrastructure to handle more traffic by doubling the number of web servers and making the system more reliable. If one web server fails, there should be a second one to handle requests.

## Tasks

### Task 0: Double the number of webservers

#### Requirements

- Configure Nginx so that its HTTP response contains a custom header (`X-Served-By`) on web-01 and web-02.
- The value of the custom HTTP header (`X-Served-By`) must be the hostname of the server Nginx is running on.

#### Steps to Accomplish

1. **Configure Nginx:**

   Write a Bash script named `0-custom_http_response_header` that configures a brand new Ubuntu machine to meet the requirements mentioned above. Ignore SC2154 for shellcheck.

   ```bash
   #!/usr/bin/env bash
   # Script to configure Nginx with custom HTTP response header

   # Install Nginx
   sudo apt-get update
   sudo apt-get install -y nginx

   # Configure Nginx to add custom header
   echo "add_header X-Served-By \$hostname;" | sudo tee -a /etc/nginx/sites-available/default

   # Restart Nginx for changes to take effect
   sudo service nginx restart
   ```

2. **Verify Configuration:**

   After running the script on both web servers, verify the custom header is added correctly using `curl` commands as shown in the example.

### Task 1: Install your load balancer

#### Requirements

- Install and configure HAproxy on your lb-01 server.
- Configure HAproxy to send traffic to web-01 and web-02 using a roundrobin algorithm.
- Make sure that HAproxy can be managed via an init script.
- Ensure that your servers are configured with the right hostnames: `[STUDENT_ID]-web-01` and `[STUDENT_ID]-web-02`.

#### Steps to Accomplish

1. **Install and Configure HAProxy:**

   Write a Bash script named `1-install_load_balancer` that configures a new Ubuntu machine to meet the requirements mentioned above.

   ```bash
   #!/usr/bin/env bash
   # Script to install and configure HAproxy as a load balancer

   # Install HAproxy
   sudo apt-get update
   sudo apt-get install -y haproxy

   # Configure HAproxy
   echo "
   frontend web_front
       bind *:80
       mode http
       default_backend web_servers

   backend web_servers
       mode http
       balance roundrobin
       server web-01 [STUDENT_ID]-web-01:80 check
       server web-02 [STUDENT_ID]-web-02:80 check" | sudo tee -a /etc/haproxy/haproxy.cfg

   # Restart HAproxy
   sudo service haproxy restart
   ```

2. **Verify Configuration:**

   Use `curl` commands to test if HAproxy is distributing requests correctly to web-01 and web-02.

## Important Notes

- Ensure that all scripts are executable (`chmod +x scriptname.sh`).
- Verify the configurations thoroughly using appropriate commands and tests.
- If there are issues, refer to the provided resources and troubleshoot the configurations.
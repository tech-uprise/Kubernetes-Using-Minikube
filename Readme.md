This is a Spring MVC web application built using the following components. 
a.	Spring v4.3.9
b.	Elasticsearch v5.4
d.	Kibana v5.4

The main goal of this project is to deploy on Kubernetes(minikube) as docker containers:

[Local Kubernetes(minikube) on macOS with  on VirtualBox + local Docker registry]

"kompose convert" is used  on "docker-compose.yml" to generate "Deployment" and "Service" artifacts to deploy on Kubernetes environment.


Pre-requisites (I have done this on macOS High Sierra): Carefully follow the steps otherwise it wouldn't work as expected:

-	Minikube requires that VT-x/AMD-v virtualization is enabled in BIOS. To verify if it's enabled on OSX / macOS run:
		sysctl -a | grep machdep.cpu.features | grep VMX [If there's output, then we are good]
-	Required components are: kubectl, docker (for Mac), minikube & virtualbox - to install them, run the following:
		brew update && brew install kubectl && brew cask install docker minikube virtualbox
-	To verify if everything is installed and running properly,from compose folder run this shell script from the terminal:
		sh version.sh
-	Start the minikube by typing this on the terminal:
		minikube start (You will see something like... "Starting local Kubernetes cluster..." wait for for kubernetes cluster to run.
-	Check to see k8s by running the following command.
		kubectl get nodes  (note this is also in version.sh but the shell script will not start the minikube, so this is again to docuble check)
-	Use minikube's built-in docker daemon(THIS IS VERY IMPORTANT)
		eval $(minikube docker-env)
-	To verify is you are inside the minikube environment, run the following command:
		docker ps
-	Since my aplication uses elasticseach and it needs the following command to be executed. Otherwise, elasticsearch process will be killed and will not come up. Additionally, you will see an 		exception in the elasticsearch log: ERROR: bootstrap checks failed. max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
		minikube ssh
		sudo sysctl -w vm.max_map_count=262144
		exit
-	To build, deploy and run an image on your local docker repo & k8s setup
		docker run -d -p 5000:5000 --restart=always --name registry registry:2
-	To build docker images and tag I used the following:
	b.	kompose convert (to create and deployment and services yaml files)
	a.	kompose up -v (That built the images and tagged - note that I've already specified versioning (0.1.0) for my images in the docker-compose.yml, no extra steps are required to tag.
	c.	delete.sh to delete everything created and deployed by kompose.
	d.	I then edited Deployment and Services manually and also specified the required Environment variables - such as elastic host, port, index name, etc.
	f.	Executed create.sh to start the deployments & services.
-	Since the images will be built and pushed to local repository, you need proper content in - /Users/<user>/.docker/config.json
	a.	Sign-up to docker hub (if you don't have an account already) and that will update your config.json.
	b.	Don’t have to stay loggedin.
	c.	The following content worked for me consistently:
		{
		"auths": 
			{"http://localhost:5000": {"auth": "a3JpdmEwMzp3aWx5MTIzNA=="},
			"https://index.docker.io/v1/": {"auth": "a3JpdmEwMzp3aWx5MTIzNA=="},
			"https://localhost:5000": {"auth": "a3JpdmEwMzp3aWx5MTIzNA=="	},
			"private-registry": {"auth": "a3JpdmEwMzp3aWx5MTIzNA=="}
			},
		"HttpHeaders": {"User-Agent": "Docker-Client/17.12.0-ce (darwin)"	},
		"credsStore": "osxkeychain"
		}
	d.	The auth key is nothing but base64 encoded string, which is your login credentials for dockerhub. I used this site to convert plain text to encoded: 
		http://www.tuxgraphics.org/toolbox/base64-javascript.html
-	The URLs will auto launch for the following:
	a.	minikube dashboard (ex: http://<IP>:30000
	b.	Tomcat (ip:port), you then append the context path - the URL should like this in the end: http://<IP>:<PORT>/spring-elastic-kibana/
	c.	Kibana UI (ex: http://<IP>:5601
	

Usage:

1.	Clone the repo or download as zip file.
2.	Extract the zip file (if downloaded as .zip) and step into docker/compose folder.
3.	Open command line editor/terminal and go into docker folder (where you saved or cloned the repo).
4. 	To build and deploy on kubernetes, from compose folder run this shell script: sh create.sh
5. To check if elasticsearch is running:
	-	Open your favorite browser and type in the following URL and hit go: http://<hot>:30000
6. To access spring based web application:
	-	Open your favorite browser and type in the following URL and hit go: http://<host>:<port>/spring-elastic-kibana
7.	To start using and build dashboards in Kibana:
	-	Open your favorite browser and type in the following URL and hit go:  http://<hot>:5601
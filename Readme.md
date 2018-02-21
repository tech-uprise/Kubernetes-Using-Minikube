This is a Spring MVC web application built using the following components. 
a.	Spring v4.3.9
b.	Elasticsearch v5.4
d.	Kibana v5.4

The main goal of this project is to deploy on Kubernetes(minikube) as docker containers:

[Local Kubernetes(minikube) on macOS with  on VirtualBox + local Docker registry]

"kompose convert" is used to convert "docker-compose.yml" to generate "Deployment" and "Service" descriptors to deploy on Kubernetes environment.


Pre-requisites (I have done this on macOS High Sierra): Carefully follow the steps otherwise it wouldn't work as expected:

-	Minikube requires that VT-x/AMD-v virtualization is enabled in BIOS. To verify if it's enabled on OSX / macOS run:
		sysctl -a | grep machdep.cpu.features | grep VMX - If there's output, then we are good.
-	Required components are: kubectl, docker, minikube & virtualbox - to install them, run the following:
		brew update && brew install kubectl && brew cask install docker minikube virtualbox
-	To verify if everything is installed and running properly, from compose folder run this shell script from the terminal:
		sh version.sh
-	Now, start the minikube by typing the following command on the terminal:
		"minikube start" (You will see something like... "Starting local Kubernetes cluster..." wait for for kubernetes cluster to start and run.
-	Check to see if k8s up/running by executing the following command.
		kubectl get nodes  (note this is also in version.sh but the shell script will not start the minikube, so this is again to double check)
-	Use minikube's built-in docker daemon to communicate with Kubernetes(THIS IS VERY IMPORTANT)
		eval $(minikube docker-env)
-	To verify if you are inside the minikube environment, run the following command:
		docker ps (there should be a couple of processes running)
-	Do "Docker images", you will see a bunch of images installed by Minikube for Kubernetes
-	Since my aplication uses elasticseach and it needs the following command to be executed. Otherwise, elasticsearch process will be killed and will not come up. Additionally, you will see an exception in the elasticsearch log: "ERROR: bootstrap checks failed. max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]"
		minikube ssh
		sudo sysctl -w vm.max_map_count=262144
		exit
-	To build, deploy and run an image on your local docker repo & k8s setup
		docker run -d -p 5000:5000 --restart=always --name registry registry:2
-	To build docker images and tag, I used the following:
	b.	kompose convert (to create and deployment and services yaml files)
	a.	kompose up -v (That built the images and tagged - note that I've already specified versioning (0.1.0) for my images in the docker-compose.yml, so no extra steps are required to tag.
	c.	run "sh delete.sh" to delete everything created and deployed by kompose.
	d.	I then edited Deployment and Services manually to specify the required Environment variables - such as elasticsearch host(service name as host), port, index name.
-	Since the images will be built and pushed to local repository, you need proper content in - /Users/<user>/.docker/config.json
	a.	Sign-up to docker hub (if you don't have an account already) as that will update your config.json.
	b.	Don’t have to stay logged-in, however the content in the JSON file matters to authenticate to local repo to push and pull the images by Kubernetes in the VirtualBox.
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
	d.	Note: The auth key is nothing but base64 encoded string, which is your login credentials for docker hub. I used this site to convert plain text to encoded: 
		http://www.tuxgraphics.org/toolbox/base64-javascript.html (the format is, username:password)
-	f.	After all that, executed "sh create.sh" to start the deployments & services.

	

Usage:

1.	Clone the repo or download as zip file.
2.	Extract the zip file (if downloaded as .zip) and step into docker/compose folder.
3.	Open command line editor/terminal and go into compose folder (where you saved or cloned the repo).
4.	To build docker images to deploy on Kubernetes, execute "docker-compose build" from terminal.
5. 	To build and deploy on kubernetes, from compose folder run this shell script: "sh create.sh"
6.	The URLs are auto launched for the following as I'm at this point I'm exposing to external world:
	a.	"minikube dashboard" (will launch: http://<IP>:30000
	b.	Tomcat (ip:port), you then append the context path - the URL should like this in the end: http://<IP>:<PORT>/spring-elastic-kibana/
	c.	Kibana UI (will launch: http://<IP>:5601
7. If Kibana is able to connect but don't see any data from application - go to Kibana UI -->Dev Tools --> Console: and run the following command:
		PUT spring_elastic_kibana
	{
    	"settings" : {
        	"index" : {
            	"number_of_shards" : 3, 
            	"number_of_replicas" : 2 
        	}
    	}
	}
	
-------------------------
Reset everything:
-------------------------

1.	minikube stop;
2.	minikube delete;
3.	rm -rf ~/.minikube .kube;
4.	brew uninstall kubectl;
5.	brew cask uninstall docker virtualbox minikube;
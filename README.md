# YOLO E-commerce Application Deployment

This repository automates the deployment of the YOLO e-commerce application using Vagrant (Stage 1) and AWS with Terraform (Stage 2). The application runs in Docker containers (frontend: Nginx, backend: Node.js, database: MongoDB) and is accessible on port 3000.

## Prerequisites
- Git
- Oracle VirtualBox (Stage 1)
- Vagrant (Stage 1)
- Ansible (host machine)
- Terraform (Stage 2)
- AWS account with access key, secret key, and SSH key pair (Stage 2)

## Stage 1: Vagrant Deployment

### Step-by-Step Guide
#### Step 1: Install Prerequisites on the Host Machine**
**Install Git:**
```bash
    sudo apt update
    sudo apt install -y git
    git --version      
```

**Install Oracle VirtualBox:**
```bash
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo apt update
sudo apt install -y virtualbox-7.0
vboxmanage --version
```
**Install Vagrant:**
```bash
wget https://releases.hashicorp.com/vagrant/2.4.1/vagrant_2.4.1_linux_amd64.deb
sudo dpkg -i vagrant_2.4.1_linux_amd64.deb
vagrant --version
```

**Install Ansible (on Host Only):**
```bash
sudo apt install -y python3 python3-pip
sudo pip3 install ansible
ansible --version
```

**Install Terraform (for Stage 2):**
```bash
wget https://releases.hashicorp.com/terraform/1.9.7/terraform_1.9.7_linux_amd64.zip
unzip terraform_1.9.7_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version
```

#### Step 2: Set Up the Project
**Clone the repository::**

```bash
git clone https://github.com/Majangajohn/yolov2.git
cd yolov2
```

**Project Structure::**

├── ansible.cfg
├── backend
│   ├── Dockerfile
│   ├── models
│   │   └── Products.js
│   ├── package.json
│   ├── package-lock.json
│   ├── routes
│   │   └── api
│   │       └── productRoute.js
│   ├── server.js
│   └── upload.js
├── backend-deployment.yaml
├── client
│   ├── Dockerfile
│   ├── nginx.conf
│   ├── package.json
│   ├── package-lock.json
│   ├── public
│   │   ├── favicon.ico
│   │   ├── index.html
│   │   ├── logo192.png
│   │   ├── logo512.png
│   │   ├── manifest.json
│   │   └── robots.txt
│   ├── README.md
│   └── src
│       ├── App.css
│       ├── App.test.js
│       ├── components
│       │   ├── AboutUs.js
│       │   ├── AddProduct.js
│       │   ├── App.js
│       │   ├── EditProductForm.js
│       │   ├── Footer.js
│       │   ├── Header.js
│       │   ├── Navbar.js
│       │   ├── NewProductForm.js
│       │   ├── ProductControl.js
│       │   ├── ProductDetail.js
│       │   ├── Product.js
│       │   ├── ProductList.js
│       │   └── ReusableForm.js
│       ├── images
│       │   ├── backgrounds
│       │   │   ├── about.jpg
│       │   │   └── hero.jpg
│       │   ├── logo
│       │   │   ├── logo.png
│       │   │   └── shop.png
│       │   ├── mouse_click.png
│       │   ├── product_image.jpeg
│       │   ├── products
│       │   │   ├── backpack.png
│       │   │   ├── giacket.png
│       │   │   ├── pants.png
│       │   │   ├── trekkingshoes.png
│       │   │   ├── tshirt_ladies.png
│       │   │   └── tshirt.png
│       │   └── social_icons
│       │       ├── facebook.png
│       │       ├── flickr.png
│       │       ├── g_plus.png
│       │       ├── pinterest.png
│       │       ├── skype.png
│       │       ├── stumble_upon.png
│       │       ├── twitter_bird.png
│       │       ├── twitter.png
│       │       └── you_tube.png
│       ├── index.js
│       ├── product-detail.css
│       ├── serviceWorker.js
│       └── setupTests.js
├── docker-compose.yaml
├── EXPLANATION.md
├── extra_disk.vdi
├── frontend-deployment.yaml
├── git.logs
├── hosts
├── image.png
├── images
│   ├── ansible-roles.png
│   ├── products-catalog.png
│   ├── vagrant-ansible-adding-product.png.png
│   ├── vagrant-ansible-landing-page.png
│   ├── vagrant-provision.png
│   ├── vagrant-up.png
│   └── vagrant-up-vm-gui.png
├── inventory.yml
├── playbook.yml
├── README.md
├── roles
│   ├── backend_container
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── vars
│   │       └── main.yml
│   ├── db_container
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── vars
│   │       └── main.yml
│   ├── frontend_container
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── vars
│   │       └── main.yml
│   └── install_docker
│       ├── tasks
│       │   └── main.yml
│       └── vars
│           └── main.yml
├── Stage_two
│   ├── ansible.cfg
│   ├── inventory.yml
│   └── terraform
│       ├── main.tf
│       ├── outputs.tf
│       ├── playbook.yml
│       ├── roles
│       │   ├── backend_container
│       │   │   ├── tasks
│       │   │   │   └── main.yml
│       │   │   └── vars
│       │   │       └── main.yml
│       │   ├── db_container
│       │   │   ├── tasks
│       │   │   │   └── main.yml
│       │   │   └── vars
│       │   │       └── main.yml
│       │   ├── frontend_container
│       │   │   ├── tasks
│       │   │   │   └── main.yml
│       │   │   └── vars
│       │   │       └── main.yml
│       │   └── install_docker
│       │       ├── tasks
│       │       │   └── main.yml
│       │       └── vars
│       │           └── main.yml
│       ├── terraform.tfstate
│       ├── terraform.tfstate.backup
│       └── variables.tf
├── Structure
└── Vagrantfile


#### Step 3: Provision the VM:
- After cloning, go to the root of the project and running the following command to provision vm
```bash
vagrant up
```
<img src="images/vagrant-up.png" alt="Application Screenshot">
<img src="images/vagrant-up-vm-gui.png" alt="Application Screenshot">

```bash
vagrant provision
```

<img src="images/vagrant-provision.png" alt="Application Screenshot">


#### Step 4: Access the Application:
- **Host Machine:** Open ```http://localhost:3000 ```in a browser.

- **VM:** SSH into the VM (```vagrant ssh```) and run curl ```http://localhost:3000```.

- Test the "Add Product" functionality to verify data persistence.

<img src="images/vagrant-ansible-landing-page.png" alt="Application Screenshot">
<img src="images/vagrant-ansible-adding-product.png" alt="Application Screenshot">
<img src="/images/products-catalog.png" alt="Application Screenshot">


#### Alternative access link to hosted platform on AWS:
http://<public_ip>:3000
<img src="images/hosted-app.png" alt="Application Screenshot">

#### Project Structure

- `Vagrantfile:` Provisions Ubuntu VM with 8 CPUs and 4GB RAM.
- `playbook.yml:` Ansible playbook defining roles.
- `roles/:` Contains roles with tasks and variables.
- `images/:` Placeholder screenshot.
- `backend/`, `client/:` Application code directories.
- `Stage_two/:` Terraform and Ansible files for AWS.
- `explanation.md:` Setup and execution details.

#### Troubleshooting

Ensure ports 3000, 5000, and 27017 are open.
Check MongoDB volume (app-mongo-data) for persistence.

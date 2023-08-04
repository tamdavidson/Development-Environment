# Development-Environment
A development/testing/cyber-range environment. The intended end goal is to have an independent environment that can be used to test tools, tactics and procedures. The domain will include diverse operating systems, applications and services that can be spun up and destroyed with little effort. The goal is to have a solution that will be consistent, reliable and repeatable.    

## RoadMap (In Progress)
- End-goal network diagram.
- Current network diagram.
- Terraform code to crate infra on esxi.
- Packer code to create VMware images.
- Create scripts using suitable solutions to install services and applications on images.
- Add more to the to-do list...


## More defined plan
### What I want from this project
For this project to be successful or to be going in the right direction, there are several points or outcomes that I want to achieve and seek to accomplish throughout the environment's development. Most goals will be linked to the actual environment. to help drive the project. However, others will be linked to personal growth. For example, I am learning new software or trying something new. These may hinder the project, or it may not. 

So, what do I want from this? There is one main goal: to have an independent virtual environment which I could use to test TTPs. But like most goals, it can be broken down into smaller, more achievable goals.
+ core infrastructure that can be deployed as code on a virtual environment
+ VMware images of a variety of flavours of operating systems created automatically for the environment
+ Services and applications installed on the images via scripts
+ Creation of a Windows domain with users, computers and GPOs
+ Ran from a small amount of code, as typed by a user
+ Be able to clear from the virtual environment with little to no trace

I do have other goals that I want to achieve with this project, but they are for another time. 

### How I think this is going to work. 
Let's start with what I have: an ESXi 7 server, a laptop, google and needs. It is not a lot, but I will do it. I have already worked on this, so I know where to start. 

#### Terraform, Infra
I want to use Terraform and use Infra as code to create the underlying structure for the independent environment. I ran into the issue of there was no Hashicorp Terraform provider that could be used with ESXi; there was one for vSphere/vCenter, which utilised the API to communicate. I did find a user-created provider >>> [josenk // terraform-provider-esxi](https://github.com/josenk/terraform-provider-esxi.git) <<< that would allow terraform to communicate with an ESXi server via SSH. Using the provider, I want Terraform to set up the infra for the environment and then progress to select the images that will be created by packer/vagrant - unsure yet - and more maybe.

#### Packer, Images

I was looking at the image creation. This I currently where I am stuck. I know I want to use Packer, but I also wish for the ISO to be stored remotely on the ESXi server. There is already a workaround for this, as other users in the past have had the same issue, which is resolved [here](https://github.com/hashicorp/packer/issues/7306#issuecomment-471004518). Creating VMware images for all my OS's in the end-game network diagram will be a massive feat. The sensible thing will be to start small with a Windows server image and maybe Windows 10 and Windows 7 images, then work up from there. Once I have one or two of these images, it will become a lot of copy & paste. There are some considerations I have that I will have to research. If that's okay with you, I will go ahead and list them below and update them when I have a solution. I might even make them issues. 

I have worked on and modified the repo [ eaksel // packer-Win2022](https://github.com/eaksel/packer-Win2022). This repo seems to work, and I could use it to create an image on the ESXi server. i have modified it for my own use and will continue to do so until i can get it how i want it to work, such as having the ISO contain in the ESXi server and the image have a basic configuration.

- windows update, roll back and select certain versions. builds
- out-of-support OS
- will the stored ISO ever get outdated?
- will it be better to validate first, such as do we have this ISO? Yes, don't download. No, download and push to ESXi

From my little work with Packer, I will have to source autoattended.xml files and PowerShell scripts from other users. I have already got some stars for future use. Learning how to script with Powershell to set up a Windows system will be interesting. 

#### Ansible?, applications & services
unsure what I will use to install applications & services on the images will update when I get there





## Acknowledgments
- [josenk // terraform-provider-esxi](https://github.com/josenk/terraform-provider-esxi.git)
- [ eaksel // packer-Win2022](https://github.com/eaksel/packer-Win2022)


  

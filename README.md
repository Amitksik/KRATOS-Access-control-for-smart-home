# KRATOS: Fine-grain Access Control for Smart Home
KRATOS is a multi-user multi-device-aware access control system designed for the smart home systems. KRATOS introduces a formal policy language that allows users to define different policies for smart home devices, specifying their needs. It also implements a policy negotiation algorithm that automatically solves and optimizes the conflicting policy requests from multiple users by leveraging user roles and priorities. Lastly, Kratos governs different policies for different users, reviewing the results of the policy negotiation and enforcing the negotiation results over the smart home devices and apps.

# KRATOS Framework
![alt text](https://github.com/Amitksik/KRATOS-Access-control-for-smart-home/blob/main/framework_journal.png)

# Installation
KRATOS has three main parts - User Interaction Module, Policy Generator and Policy Execution. We have integrated Policy negotiation technique as a notification system in policy execution module.

### 1. User Interaction Module:
User interaction module create a user interface to add new users and device policies to the smart home system. We have created a Samsung SmartThings app (Kratos app in Integration folder) to build the user interaction module. This app provides a GUi to the users smartphones (similar to following images).

<p float="left">
  <img src="https://github.com/Amitksik/KRATOS-Access-control-for-smart-home/blob/main/Images/usermanagement.PNG" width="300" height="500">
  <img src="https://github.com/Amitksik/KRATOS-Access-control-for-smart-home/blob/main/Images/policymanagement.PNG" width="300" height="500" /> 
  <img src="https://github.com/Amitksik/KRATOS-Access-control-for-smart-home/blob/main/Images/instruction.jpg" width="300" height="500" />
</p>


### 2. Policy Generator:
Policy genrator of KRATOS uses MATLAB to create a online server. It captures the policies from user interaction module via backened server (online google spreadsheet as server) and starts policy generation process. It creates the final policies and starts the policy negotiation if necessary.

### 3. Policy Execution:
KRATOS enforce policies both in the devices and smart home apps. We have integrated KRATOS in Samsung SmartThings platforms and modified SmartThings apps and device handlers (SmartThings Integration folder). We will soon release an automated tool to modify smart home apps to integrate KRATOS in different platforms.


# Publication and Reference
Please check our recent publication in the Proceedings of the 13th ACM Conference on Security and Privacy in Wireless and Mobile Networks.
[1] Amit Kumar Sikder, Leonardo Babun, Z. Berkay Celik, Abbas Acar, Hidayet Aksu, Patrick McDaniel, Engin Kirda, and A. Selcuk Uluagac. "Kratos: multi-user multi-device-aware access control system for the smart home." In Proceedings of the 13th ACM Conference on Security and Privacy in Wireless and Mobile Networks, pp. 1-12. 2020.

@inproceedings{sikder2020kratos,<br />
  title={Kratos: multi-user multi-device-aware access control system for the smart home},<br />
  author={Sikder, Amit Kumar and Babun, Leonardo and Celik, Z Berkay and Acar, Abbas and Aksu, Hidayet and McDaniel, Patrick and Kirda, Engin and Uluagac, A Selcuk},<br />
  booktitle={Proceedings of the 13th ACM Conference on Security and Privacy in Wireless and Mobile Networks},<br />
  pages={1--12},<br />
  year={2020}<br />
}

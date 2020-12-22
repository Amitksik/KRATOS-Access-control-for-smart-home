# KRATOS: Fine-grain Access Control for Smart Home
KRATOS is a multi-user multi-device-aware access control system designed for the smart home systems. KRATOS introduces a formal policy language that allows users to define different policies for smart home devices, specifying their needs. It also implements a policy negotiation algorithm that automatically solves and optimizes the conflicting policy requests from multiple users by leveraging user roles and priorities. Lastly, Kratos governs different policies for different users, reviewing the results of the policy negotiation and enforcing the negotiation results over the smart home devices and apps.

# KRATOS Framework
![alt text](https://github.com/Amitksik/KRATOS-Access-control-for-smart-home/blob/main/framework_journal.png)

# Installation
KRATOS has three main parts - User Interaction Module, Policy Generator and Policy Execution. We have integrated Policy negotiation technique as a notification system in policy execution module.

1. User Interaction Module:
User interaction module create a user interface to add new users and device policies to the smart home system. We have created a Samsung SmartThings app (Kratos app in Integration folder) to build the user interaction module. This app provides a GUi to the users smartphones (similar to following images).

<p float="left">
  <img src="https://github.com/Amitksik/KRATOS-Access-control-for-smart-home/blob/main/Images/usermanagement.PNG" width="300" height="500">
  <img src="https://github.com/Amitksik/KRATOS-Access-control-for-smart-home/blob/main/Images/policymanagement.PNG" width="300" height="500" /> 
  <img src="https://github.com/Amitksik/KRATOS-Access-control-for-smart-home/blob/main/Images/instruction.jpg" width="300" height="500" />
</p>


1. Policy Generator:
Policy genrator of KRATOS uses MATLAB to create a online server. 

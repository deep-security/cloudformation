# AWS CloudFormation templates for Deep Security

This repo contains a collection of AWS CloudFormation templates that will help you deploy the Deep Security Manager.

Project contains 2 sets of templates. The marketplace folder contains the top level and Deep Security Manager node templates for deploying from the Deep Security Marketplace AMI. RHEL contains versions for deploying on an amazon RHEL 6 AMI. The Common folder contains nested templates for objects which are common to both deployment types, including ELBs, Security Groups, and RDS.

Each nested template should be maintained such that it can be run standalone, for instance to create an RDS instance seperately from Manager nodes for a staged deployment, to add an additional Manager node to scale out an existing implementation, or for easier integration with other custom template use cases.

## Support

This is a community project and while you will see contributions from the Deep Security team, there is no official Trend Micro support for this project. The official documentation for the Deep Security APIs is available from the [Trend Micro Online Help Centre](http://docs.trendmicro.com/en-us/enterprise/deep-security.aspx). 

Tutorials, feature-specific help, and other information about Deep Security is available from the [Deep Security Help Center](https://help.deepsecurity.trendmicro.com/Welcome.html). 

For Deep Security specific issues, please use the regular Trend Micro support channels. For issues with the code in this repository, please [open an issue here on GitHub](https://github.com/deep-security/cloudformation/issues).

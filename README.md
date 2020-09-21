# AWS CloudFormation Templates for Deep Security

This repository contains a collection of AWS CloudFormation templates that will help you deploy Deep Security Manager.

## Table of Contents

* [Usage](#usage)
* [Support](#support)
* [Contribute](#contribute)

## Usage

This project contains 2 sets of templates. The "marketplace" folder contains the top level and Deep Security Manager node templates for deploying from the Deep Security Marketplace AMI. RHEL contains versions for deploying on an Amazon RHEL 7 AMI. The "common" folder contains nested templates for objects which are common to both deployment types, including ELBs, Security Groups, and RDS.

Each nested template should be maintained such that it can be run standalone (for example, to create an RDS instance seperately from manager nodes for a staged deployment, to add an additional manager node to scale out an existing implementation, or for easier integration with other custom template use cases).


## Support

This is an Open Source community project. Project contributors may be able to help, 
depending on their time and availability. Please be specific about what you're 
trying to do, your system, and steps to reproduce the problem.

For bug reports or feature requests, please 
[open an issue](../issues). 
You are welcome to [contribute](#contribute).

Official support from Trend Micro is not available. Individual contributors may be 
Trend Micro employees, but are not official support.

## Contribute

We accept contributions from the community. To submit changes:

1. Fork this repository.
1. Create a new feature branch.
1. Make your changes.
1. Submit a pull request with an explanation of your changes or additions.

We will review and work with you to release the code.

# AWS AMI for CSYE 6225

## Team Information

|                Name            | NEU ID    |         Email Address              |
| ------------------------------ | --------- | ---------------------------------- |
|Sumanth Hagalavadi Gopalakrishna| 001824723 | hagalavadigopalakr.s@husky.neu.edu |
|Prashant Kabra                  | 001238302 | kabra.p@husky.neu.edu              |
|Ashish harishchandra Gurav      | 001837129 | gurav.a@husky.neu.edu              |
|Nivetha Ganeshjeevan	         | 001206641 | ganeshjeevan.n@husky.neu.edu       |

## Validate Template

Validate template json using the following command.

packer validate centos-ami-template.json


## Build AMI

Build AMI using the following command.

packer build centos-ami-template.json


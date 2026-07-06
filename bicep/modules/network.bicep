param location string = resourceGroup().location

param vnetName string = 'vnet-webapp-demo'

param vnetAddressPrefix string = '10.0.0.0/16'

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {

 name: vnetName
 location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [ 
      {
       name: 'web-subnet'
       properties: {
        addressPrefix: '10.0.1.0/24'
      }
    }
    {
      name: 'app-subnet'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    {
        name: 'mgmt-subnet'
        properties: {
          addressPrefix: '10.0.3.0/24'
        }
      }
       {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.0.4.0/26'
        }
       }
    ]
  }
}

output vnetId string = vnet.id
output webSubnetId string = vnet.properties.subnets[0].id

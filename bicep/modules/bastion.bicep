param location string = resourceGroup().location

param bastionName string = 'bastion-webapp-demo'

param vnetName string = 'vnet-webapp-demo'

resource publicIP  'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: 'pip-${bastionName}'
  location: location
  sku: {
     name: 'Standard'
  }
  properties: {
     publicIPAllocationMethod: 'Static'
  }
}

resource bastion 'Microsoft.Network/bastionHosts@2023-09-01' = {
  name: bastionName
  location: location
  sku: {
     name: 'Basic'
  }
  properties: {
     ipConfigurations: [
       {
         name: 'bastionIpConfig'
          properties: {
            publicIPAddress: {
              id: publicIP.id
            }
            subnet: {
              id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, 'AzureBastionSubnet')

            }
          }
       }
     ]
  }
}

output bastionId string = bastion.id

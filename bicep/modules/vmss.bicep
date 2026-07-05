param location string = resourceGroup().location

param vmssName string = 'vmss-webapp-demo'

param webSubnetId string

param backendPoolId string

param adminUsername string = 'azureadmin'

@secure()
param adminPassword string

param instanceCount  int = 2

param vmSize string = 'Standard_B2ats_v2'

resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2023-09-01' = {
  name: vmssName
  location: location
  sku: {
    name: vmSize
    tier: 'Standard'
    capacity: instanceCount
  }
  properties: {
    upgradePolicy: {
      mode: 'Manual'
    }
    virtualMachineProfile: {
      osProfile: {
        computerNamePrefix: 'webvm'
        adminUsername: adminUsername
        adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
          publisher: 'Canonical'
          offer: '0001-com-ubuntu-server-jammy'
          sku: '22_04-lts-gen2'
          version: 'latest'
      }
    }
    networkProfile: {
      networkInterfaceConfigurations: [
         {
          name: 'nic-${vmssName}'
          properties: {
            primary: true
            ipConfigurations: [
               {
                 name: 'ipconfig1'
                  properties: {
                    subnet: {
                      id: webSubnetId
                    }
                     loadBalancerBackendAddressPools: [
                      {
                        id: backendPoolId
                      }
                   ]
                  }
                }
              ]
            }
          }
        ]
      }
    }
  }
}

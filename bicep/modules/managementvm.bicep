param location string = resourceGroup().location

param vmName string = 'vm-mgmt-demo'

param appSubnetId string

param adminUsername string = 'azureadmin'

@secure()
param adminPassword string

param vmSize string = 'Standard_B2ats_v2'

resource nic 'Microsoft.Network/networkInterfaces@2023-09-01' = {
  name: 'nic-${vmName}'
  location: location
  properties: {
    ipConfigurations: [
       {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: appSubnetId
          }
          privateIPAllocationMethod: 'Dynamic'
        }
       }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
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
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
         {
          id: nic.id
         }
      ]
    } 
  }
}

output vmId string = vm.id
output vmName string = vm.name

param location string = resourceGroup().location

param lbName string = 'lb-webapp-demo'

resource publicIP 'Microsoft.Network/publicIPAddresses@2023-09-01'= {
  name: 'pip-${lbName}'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
   publicIPAllocationMethod:'Static'
  }
}

resource loadBalancer 'Microsoft.Network/loadBalancers@2023-09-01' = {
  name: lbName
  location:location
  sku: {
    name:'Standard'
  }
  properties: {
     frontendIPConfigurations: [
       {
        name: 'LoadBalancerFrontEnd'
        properties: {
          publicIPAddress: {
            id: publicIP.id
          }
        }
       }
     ]
     backendAddressPools: [
       {
        name: 'backendPool'
       }
     ]
     probes: [
       {
        name: 'httpProbe'
        properties: {
          protocol: 'Tcp'
          port: 80
          intervalInSeconds: 15
          numberOfProbes: 2
        }
       }
     ]
     loadBalancingRules: [
      {
        name: 'httpRule'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/loadBalancers/frontendIPConfigurations', lbName, 'LoadBalancerFrontEnd')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', lbName, 'backendPool')
          }
          probe: {
            id: resourceId('Microsoft.Network/loadBalancers/probes', lbName, 'httpProbe')
          }
          protocol: 'Tcp'
          frontendPort: 80
          backendPort: 80
        }
      }
    ]
  }
}

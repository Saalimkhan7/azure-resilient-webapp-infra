param location string = resourceGroup().location

param vaultName string = 'rsv-webapp-demo'

resource recoveryVault 'Microsoft.RecoveryServices/vaults@2023-06-01' = {
  name: vaultName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: { }  
}

 resource backupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-06-01' = {
  parent: recoveryVault
  name: 'daily-backup-policy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2026-01-01T02:00:00Z'
      ]
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
         retentionTimes: [
          '2026-01-01T02:00:00Z'
        ]
         retentionDuration: {
          count: 7
          durationType: 'Days'
        }
      }
    }
  }
 }

 output vaultId string = recoveryVault.id
output vaultName string = recoveryVault.name

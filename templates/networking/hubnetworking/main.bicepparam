using './main.bicep'

// General Parameters
param parLocations = [
  'uksouth'
  ''
]
param parGlobalResourceLock = {
  name: 'GlobalResourceLock'
  kind: 'None'
  notes: 'This lock was created by the ALZ Bicep Accelerator.'
}
param parTags = {}
param parEnableTelemetry = true

// Resource Group Parameters
param parHubNetworkingResourceGroupNamePrefix = 'CTG-RG-PRD-UKS-CONN'
param parDnsResourceGroupNamePrefix = 'CTG-RG-PRD-UKS-DNS'
param parDnsPrivateResolverResourceGroupNamePrefix = 'CTG-RG-PRD-UKS-PDNSR'

// Hub Networking Parameters
param hubNetworks = [
  {
    name: 'CTG-VNET-PRD-UKS-CONN'
    location: parLocations[0]
    addressPrefixes: [
      '10.129.6.0/23'
    ]
    deployPeering: false
    dnsServers: []
  }
    ]
    subnets: [
      {
        name: 'AzureBastionSubnet'
        addressPrefix: '10.129.6.64/26'
      }
      {
        name: 'GatewaySubnet'
        addressPrefix: '10.129.6.128/27'
      }
      {
        name: 'AzureFirewallSubnet'
        addressPrefix: '10.129.6.0/26'
      }
      {
        name: 'AzureFirewallManagementSubnet'
        addressPrefix: '10.129.6.192/26'
      }
      {
        name: 'DNSPrivateResolverInboundSubnet'
        addressPrefix: '10.129.6.160/28'
        delegation: 'Microsoft.Network/dnsResolvers'
      }
      {
        name: 'DNSPrivateResolverOutboundSubnet'
        addressPrefix: '10.129.6.176/28'
        delegation: 'Microsoft.Network/dnsResolvers'
      }
    ]
    azureFirewallSettings: {
      deployAzureFirewall: true
      azureFirewallName: 'CTG-AFW-PRD-UKS-CONN'
      azureSkuTier: 'Standard'
      publicIPAddressObject: {
        name: 'CTG-PIP-AFW-PRD-UKS-CONN'
      }
      managementIPAddressObject: {
        name: 'CTG-PIP-AFW-MGMT-PRD-UKS-CONN'
      }
    }
    bastionHostSettings: {
      deployBastion: true
      bastionHostSettingsName: 'CTG-BAS-PRD-UKS-CONN'
      skuName: 'Standard'
    }
    vpnGatewaySettings: {
      deployVpnGateway: true
      name: 'CTG-VGW-PRD-UKS-CONN'
      skuName: 'VpnGw1AZ'
      vpnMode: 'activeActiveBgp'
      vpnType: 'RouteBased'
      asn: 65515
    }
    expressRouteGatewaySettings: {
      deployExpressRouteGateway: true
      name: 'CTG-EGW-PRD-UKS-CONN'
      azureSkuTier: 'ErGw1AZ'
    }
    privateDnsSettings: {
      deployPrivateDnsZones: true
      deployDnsPrivateResolver: true
      privateDnsResolverName: 'CTG-PDNSR-PRD-UKS-CONN'
      privateDnsZones: []
    }
    ddosProtectionPlanSettings: {
      deployDdosProtectionPlan: true
      name: 'CTG-DDOS-PRD-UKS-CONN'
    }
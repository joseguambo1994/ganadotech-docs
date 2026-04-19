workspace {

    model {
        user = person "User" {
            description "Farm owner or operator"
        }

        sheepMonitoringSystem = softwareSystem "Sheep Monitoring System" {
            description "Monitors sheep with on-premises camera capture and cloud-based counting"

            ip_camera = container "IP Camera" {
                description "Captures video feed from the farm"
                technology "Embedded camera device"
            }

            local_worker = container "Local Worker Server" {
                description "Processes and encrypts the video feed locally"
                technology "Server application"
            }

            vps_app = container "Hostinger VPS Python App" {
                description "Python application that analyzes video and counts sheep"
                technology "Python"
            }

            database = container "Database" {
                description "Data video intelligence results and sheep count storage"
                technology "SupaBase (PostgreSQL)"
            }

            blob_storage = container "Blob Storage" {
                description "Processed video for retrieval"
                technology "CloudFlare R2"
            }

            mobile_app = container "Mobile App" {
                description "Mobile application for farm monitoring and sheep count display"
                technology "Expo React Native"
            }

            api_gateway = container "API Gateway" {
                description "Routes external API requests to the Python API and BFF"
                technology "KrakenD"
            }

            bff = container "Backend for Frontend (BFF)" {
                description "API layer for mobile app communication"
                technology "DotNet 8 Web API"
            }

            user -> mobile_app "Monitors and configures"
            ip_camera -> local_worker "Sends video feed"
            local_worker -> api_gateway "Sends encrypted video data"
            api_gateway -> vps_app "Exposes Python API"
            api_gateway -> bff "Exposes BFF API"
            vps_app -> database "Stores analysis results and sheep count"
            vps_app -> blob_storage "Stores processed video"
            mobile_app -> api_gateway "Fetches sheep count and video"
            bff -> database "Fetches sheep count data"
            bff -> blob_storage "Fetches processed video"


        }

        deploymentEnvironment "Production" {
            deploymentNode "Farm" {
                deploymentNode "IP Camera" {
                    technology "Camera Device"
                    containerInstance ip_camera
                }

                deploymentNode "Worker Server" {
                    technology "On-premises server"
                    containerInstance local_worker
                }
            }

            deploymentNode "Hostinger VPS" {
                technology "Cloud VPS"
                deploymentNode "API Gateway" {
                    technology "KrakenD"
                    containerInstance api_gateway
                }
                deploymentNode "Python Application" {
                    technology "Ubuntu / Python"
                    containerInstance vps_app
                }
                deploymentNode "Dotnet 8 Application" {
                    technology "DotNet"
                    containerInstance bff
                }
            }

            deploymentNode "User Terminal" {
                containerInstance mobile_app
            }

            deploymentNode "Cloudflare" {
                containerInstance blob_storage
            }

            deploymentNode "SupaBase" {
                containerInstance database
            }
        }
    }

    views {
        systemContext sheepMonitoringSystem "C1_System_Context" {
            include *
            autolayout lr
        }

        deployment sheepMonitoringSystem "Production" {
            include *
            autolayout lr 50 200
        }

        styles {
            element "Person" {
                shape Person
                background #08427b
                color #ffffff
            }

            element "Database" {
                shape Cylinder
            }
        }
    }

}

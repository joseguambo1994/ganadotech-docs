workspace {

    model {
        user = person "User" {
            description "Farm owner or operator"
        }

        administrator = person "Administrator / Developer" {
            description "Administrators and developers who own and operate the system"
        }

        cloudflare = softwareSystem "Cloudflare R2" {
            description "External object storage for raw and processed videos"
            tags "Other"
        }

        supabase = softwareSystem "Supabase" {
            description "External PostgreSQL database for video intelligence results and sheep counts"
            tags "Database"
        }

        sheepMonitoringSystem = softwareSystem "Sheep Monitoring System" {
            description "Monitors sheep with on-premises camera capture and cloud-based counting"

            ip_camera = container "IP Camera" {
                description "Captures video feed from the farm"
                technology "Embedded camera device"
                tags "Other"
            }

            local_worker = container "Local Worker Server" {
                description "Processes and encrypts the video feed locally"
                technology "Server application"
                tags "Backend"
            }

            vps_app = container "Hostinger VPS Python App" {
                description "Python application that polls stored videos, analyzes them, and counts sheep"
                technology "Python"
                tags "Backend"
            }

            pwa_app = container "User PWA" {
                description "Progressive web app for farm monitoring and sheep count display"
                technology "Progressive Web App (PWA)"
                tags "Frontend"
            }

            admin_frontend = container "Admin Frontend" {
                description "Web frontend for administrators and developers to operate the system"
                technology "Web Frontend"
                tags "Frontend"
            }

            identity_provider = container "Identity Provider" {
                description "Authenticates users, administrators, and developers"
                technology "Keycloak"
                tags "Other"
            }

            api_gateway = container "API Gateway" {
                description "Routes external API requests to the PWA backend and admin backend"
                technology "KrakenD"
                tags "API Gateway"
            }

            pwa_bff = container "PWA Backend for Frontend (BFF)" {
                description "API layer for PWA communication"
                technology "DotNet 8 Web API"
                tags "Backend"
            }

            admin_backend = container "Admin Backend" {
                description "API layer for administrator and developer operations"
                technology "DotNet 8 Web API"
                tags "Backend"
            }

            user -> pwa_app "Monitors and configures"
            administrator -> admin_frontend "Administers and maintains the system"
            pwa_app -> identity_provider "Authenticates users"
            admin_frontend -> identity_provider "Authenticates administrators and developers"
            admin_frontend -> api_gateway "Uses admin APIs"
            ip_camera -> local_worker "Sends video feed"
            local_worker -> cloudflare "Stores encrypted video"
            api_gateway -> identity_provider "Validates access tokens"
            api_gateway -> pwa_bff "Routes PWA API requests"
            api_gateway -> admin_backend "Routes admin API requests"
            vps_app -> supabase "Stores analysis results and sheep count"
            vps_app -> cloudflare "Polls videos to process and stores processed video"
            pwa_app -> api_gateway "Fetches sheep count and video"
            pwa_bff -> supabase "Fetches sheep count data"
            pwa_bff -> cloudflare "Fetches processed video"
            admin_backend -> supabase "Manages sheep count data"
            admin_backend -> cloudflare "Manages processed video"


        }

        sheepMonitoringSystem -> cloudflare "Stores and retrieves raw and processed videos"
        sheepMonitoringSystem -> supabase "Stores and retrieves sheep count data"

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
                deploymentNode "Identity Provider" {
                    technology "Keycloak"
                    containerInstance identity_provider
                }
                deploymentNode "Python Application" {
                    technology "Ubuntu / Python"
                    containerInstance vps_app
                }
                deploymentNode "PWA Backend Application" {
                    technology "DotNet"
                    containerInstance pwa_bff
                }
                deploymentNode "Admin Backend Application" {
                    technology "DotNet"
                    containerInstance admin_backend
                }
            }

            deploymentNode "User Terminal" {
                technology "Web browser"
                containerInstance pwa_app
            }

            deploymentNode "Admin Terminal" {
                technology "Web browser"
                containerInstance admin_frontend
            }

            deploymentNode "Cloudflare" {
                technology "Cloudflare R2"
                softwareSystemInstance cloudflare
            }

            deploymentNode "Supabase" {
                technology "PostgreSQL"
                softwareSystemInstance supabase
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
                background #ffd966
                color #000000
            }

            element "Frontend" {
                background #c00000
                color #ffffff
            }

            element "Backend" {
                background #9dc3e6
                color #000000
            }

            element "API Gateway" {
                background #70ad47
                color #000000
            }

            element "Other" {
                background #d9d9d9
                color #000000
            }
        }
    }

}

workspace {

    model {
        user = person "User" {
            description "Farm owner or operator"
        }

        sheepMonitoringSystem = softwareSystem "Sheep Monitoring System" {
            description "Monitors sheep with on-premises camera capture and cloud-based counting"

            ipCamera = container "IP Camera" {
                description "Captures video feed from the farm"
                technology "Embedded camera device"
            }

            localWorker = container "Local Worker Server" {
                description "Processes and encrypts the video feed locally"
                technology "Server application"
            }

            vpsPythonApp = container "Hostinger VPS Python App" {
                description "Python application that analyzes video and counts sheep"
                technology "Python"
            }

            user -> ipCamera "Monitors and configures"
            ipCamera -> localWorker "Sends video feed"
            localWorker -> vpsPythonApp "Sends encrypted video data"
        }

        deploymentEnvironment "Production" {
            deploymentNode "Farm" {
                deploymentNode "IP Camera" {
                    technology "Camera Device"
                    containerInstance ipCamera
                }

                deploymentNode "Worker Server" {
                    technology "On-premises server"
                    containerInstance localWorker
                }
            }

            deploymentNode "Hostinger VPS" {
                technology "Cloud VPS"
                deploymentNode "Python Application" {
                    technology "Ubuntu / Python"
                    containerInstance vpsPythonApp
                }
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
            autolayout lr
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

            element "Data Store" {
                shape Cylinder
            }
        }
    }

}

# A Simple Example of Blue-Green Deployment

# Table of Contents

- [Summary](#summary)
- [Explanation: What's the *blue-green deployment*?](#explanation-whats-the-blue-green-deployment)
- [Steps: How it works?](#steps-how-it-works)
- [Advanced Deployment Strategies Using External Services](#advanced-deployment-strategies-using-external-services)

## Summary
This repository serves as an example of the blue-green deployment strategy. It is designed to help individuals **practice** the deployment process before delving into the development of a CI/CD pipeline.

## Explanation: What's the *blue-green deployment*?

The blue-green deployment strategy is a technique used in software development to minimize downtime and ensure smooth deployments. By maintaining two identical environments, referred to as the "blue" and "green" environments, developers can seamlessly switch between them during deployments. This approach allows for testing and validation of the new version in the green environment while the blue environment continues to serve production traffic. Once the green environment is deemed stable, the switch is made, and the green environment becomes the new production environment.

Feel free to explore the contents of this repository and follow the provided instructions to gain a better understanding of blue-green deployments.

### Some other great resources about CI/CD pipeline with GitHub Actions and blue-green deployment

To know more about blue-green deployment, Check out [Blue/green deployments](https://docs.aws.amazon.com/whitepapers/latest/overview-deployment-options/bluegreen-deployments.html#:~:text=A%20blue%2Fgreen%20deployment%20is,running%20the%20new%20application%20version.)

[About Building CI/CD](https://medium.com/@ugurcanerdogan/full-stack-application-deployment-with-docker-aws-ec2-and-github-actions-c27e81d134b2)

[OIDC for GitHub Actions with AWS](https://medium.com/israeli-tech-radar/openid-connect-and-github-actions-to-authenticate-with-amazon-web-services-9a66b3b88e92)


## Steps: How it works?

In main.sh: 

    1. Check which container is running between blue and green containers.

    2. Distinguish which container will stop and which container will start.

    3. Run the new container.

    4. Wait for the new container to complete its start.

    5. Confirm if the new container started without any problem.

    6. Replace the old conf file with a new one!
        {
            sudo cp /etc/server-blocks/<app name>/<blue || green>.conf /etc/nginx/conf.d/<app name>.conf
            sudo nginx -s -reload
        }

Now, you can run the main.sh script with GitHub Actions for better automation.

## Advanced Deployment Strategies Using External Services

While the blue-green deployment strategy outlined in this repository provides a solid foundation for understanding deployment processes, it's important to note that there are more advanced and efficient methods available through external deployment services. These services offer enhanced features such as automated rollbacks, traffic splitting, canary releases, and more comprehensive monitoring capabilities, which can significantly streamline the deployment process.

### Benefits of Using External Deployment Services:

- **Automated Rollbacks**: Quickly revert to the previous version if issues are detected post-deployment, minimizing downtime and impact on users.
- **Traffic Splitting**: Gradually route a percentage of user traffic to the new version, allowing for more controlled testing in production.
- **Canary Releases**: Similar to traffic splitting, this allows for deploying new versions to a small subset of users before a full rollout.
- **Enhanced Monitoring and Alerts**: Get real-time insights into the deployment process and application performance, enabling faster response to any issues.

### Recommended External Deployment Services:

- **AWS CodeDeploy**: Offers automated deployments to Amazon EC2 instances, AWS Fargate, AWS Lambda, and your on-premises servers.
- **Azure DevOps**: Provides a suite of tools for CI/CD pipelines, allowing for seamless deployments to various environments.
- **Google Cloud Deploy**: A managed service that automates the delivery of applications to Google Kubernetes Engine (GKE) clusters.
- **Heroku**: A platform as a service (PaaS) that enables developers to build, run, and operate applications entirely in the cloud.

Exploring these external services can provide a more scalable and efficient deployment process, allowing teams to focus more on development and less on the operational complexities of deployment strategies.
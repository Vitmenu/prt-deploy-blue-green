# A Simple Example of Blue-Green Deployment

## Summary
This repository serves as an example of the blue-green deployment strategy. It is designed to help individuals **practice** the deployment process before delving into the development of a CI/CD pipeline.

## Explanation: What's the *blue-green deployment*?

The blue-green deployment strategy is a technique used in software development to minimize downtime and ensure smooth deployments. By maintaining two identical environments, referred to as the "blue" and "green" environments, developers can seamlessly switch between them during deployments. This approach allows for testing and validation of the new version in the green environment while the blue environment continues to serve production traffic. Once the green environment is deemed stable, the switch is made, and the green environment becomes the new production environment.

Feel free to explore the contents of this repository and follow the provided instructions to gain a better understanding of blue-green deployments.

**To know more about blue-green deployment, Check out [this link!](https://docs.aws.amazon.com/whitepapers/latest/overview-deployment-options/bluegreen-deployments.html#:~:text=A%20blue%2Fgreen%20deployment%20is,running%20the%20new%20application%20version.)**

Some other great resources about CI/CD pipeline with GitHub Actions

[About Building CI/CD](https://medium.com/@ugurcanerdogan/full-stack-application-deployment-with-docker-aws-ec2-and-github-actions-c27e81d134b2)

[OIDC for GitHub Actions with AWS](https://medium.com/israeli-tech-radar/openid-connect-and-github-actions-to-authenticate-with-amazon-web-services-9a66b3b88e92)


## Steps: How it works?

main.sh: {
    1. Check which container is running between blue and green containers.

    2. Distinguish which container will stop and which container will start.

    3. Run the new container.

    4. Wait for the new container to complete its start.

    5. Confirm if the new container started without any problem.

    6. Replace /etc/nginx/nginx.conf with /etc/nginx/pre/nginx.<blue || green>.conf by running those commands.
        {
            sudo cp /etc/nginx/pre/nginx.<blue || green>.conf /etc/nginx/nginx.conf
            sudo nginx -s -reload
        } || {
            sudo cp /etc/nginx/pre/<server-name>/<blue || green>.conf /etc/nginx/conf.d/<server-name>.conf
            sudo nginx -s -reload
        }
}

Now, you can run the main.sh script with GitHub Actions for better automation.
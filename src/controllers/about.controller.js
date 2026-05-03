const getAbout = (req, res) => {
  res.status(200).json({
    success: true,
    project: "Docker Node.js AWS GitHub Actions CI/CD",
    description: "A production-ready REST API built to demonstrate a full CI/CD pipeline from code to cloud.",
    techStack: {
      runtime: "Node.js v22",
      framework: "Express.js",
      containerization: "Docker",
      cicd: "GitHub Actions",
      registry: "Docker Hub",
      cloud: "AWS EC2",
    },
    pipeline: [
      "1. Push code to GitHub",
      "2. GitHub Actions triggers automatically",
      "3. Docker image is built",
      "4. Image is pushed to Docker Hub",
      "5. AWS EC2 pulls the latest image",
      "6. Container restarts with new version",
    ],
    repository: "https://github.com/Zubair-624/docker-nodejs-aws-github-actions-cicd",
  });
};

module.exports = { getAbout };
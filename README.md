# Sentry Performance Monitoring

A reference of this article is available on the Rungutan Blog here -> https://rungutan.com/blog/sentry-performance-monitoring/.

## What is Performance Monitoring?

Performance monitoring in web analytics is the act of regularly verifying and tracking how well and how consistently your digital platforms are performing. Tools for digital performance monitoring include dashboards and alert systems. By selecting a handful of strategic KPIs that you track regularly, you can easily monitor digital performance and take action if major changes in performance occur.

Performance Monitoring is basically a set of processes and tools to be able to determine how well fast applications are running in the cloud. Due to the nature of cloud applications being highly distributed, special software is required to be able to trace where traffic is going between networks and applications to truly understand how well an application is performing. There is an entire industry dedicated to measuring how well cloud applications, infrastructure, and networks perform, called Application Performance Monitoring (APM). APM tools will tell you the latency a user may expect on your website, or where a bottleneck in your network is based on telemetry it is measuring. APM tools are installed by developers and infrastructure engineers, and operations teams monitor these systems that are live to make sure all systems are healthy.

In short -> When your website brings home its report card.

## What is Sentry?

Sentry is a service that helps you monitor and fix crashes in realtime. The server is in Python, but it contains a full API for sending events from 
any language, in any application.

With Performance Monitoring, teams can trace slow-loading pages back to its API call as well as surface all related errors. That way, Engineering Managers and Developers can resolve bottlenecks and deliver fast, reliable experiences that fit customer demands.

### Web vitals

More important than understanding that there’s been an error is understanding how your users have been impacted by that error. By gathering field data (variable network speed, browser, device, region) via Google’s Web Vitals, Performance helps you understand what’s happening at your user’s level. Now you know whether your users are suffering from slow loading times, seeing unexpected changes, or having trouble interacting with the page.

### Tracing

Trace poor-performing pages not only to its API call but to its children. Performance’s event detail waterfall visualizes your customer’s experience from beginning to end, all while connecting user device data to its expected operation.

### Transaction monitoring

With performance monitoring, you can view transactions by slowest duration time, related issues, or the number of users — all in one consolidated view. And release markers add another layer of context so your team can gauge how customers react to code recently pushed to production.

<p align="center">
  <img src="https://www.sentry.dev/_assets2/static/performance-transaction-057741f88cb49584c594afa9279a109b.png" width="290">
  <img src="https://www.sentry.dev/_assets2/static/vitals_macro-9f3d3b643cf0cd044ff490bcc87f889d.png" width="290">
  <img src="https://www.sentry.dev/_assets2/static/performance-waterfall-4cf0f3924387628fb6f537dc050f9871.png" width="290">
</p>


## How do Sentry and Rungutan work together?

Rungutan and Sentry are two pieces of the same puzzle: capturing and observing user activity on your platform.

Your platform, along all other API platforms on the internet, is very sensitive. Any tweak, any non-optimium piece of code, any inappropriate change of infrastructure can create a huge ripple on your user's experience.

That's why, being in constant connection with your platform behaves at any moment in time, is of vital necessity to every technical person out there.

Let's be honest. These platforms are our babies. They're one of the best things that came out of our minds and they should be treated with the out-most respect the truly deserve.

That is exactly why load testing, monitoring and alerting after every release is of vital importance!.

In short -> Rungutan simulates high user activity and Sentry tells you the exact piece of code causing problems at scale.

## How do I deploy it?

Let me make it clear before we go any further -> **Sentry** prides itself for being [open-source](https://sentry.io/_/open-source/) but it does offer a cloud-based solution as a [SaaS](https://sentry.io/welcome/) for those who do not want to deploy, manage and maintain the infrastructure for it.

There are a few community contributed ways of deploying it on premise if you do decide to not for the cloud version:

* One of the ways is use with **docker-compose** mentioned in one of Sentry's official GitHub repositories - [getsentry/onpremise](https://github.com/getsentry/onpremise)
* Another way is a community built **HELM** package available in this repo - [sentry-kubernetes/charts](https://github.com/sentry-kubernetes/charts)


Both of these solutions though have some downsides, specifically:

* Scaling ingestion of events is a bit hard due to the hard capacity limits of both solutions
* It is a well known fact that database systems perform better on NON-docker infrastructure points
* Keeping up with the different changes in versions is usually a hassle
* Customizing the different bits and pieces such as integrations require a lot of man hours


That's why, for those of you who use **Amazon Web Services** as their preferred cloud provider, we came in your help with **a fully scalable, easy to maintain and secure infrastructure** based on the following AWS services:

* AWS ECS Fargate
* AWS RDS
* AWS ElastiCache
* AWS MSK (Kafka)
* AWS OpsWorks
* AWS VPC
* AWS CloudWatch


Here's how a diagram of the deployed infrastructure looks like:

<p align="center">
  <img src="https://rungutan.com/img/sentry-rungutan-ecs-infrastructure.png">
</p>


You can deploy it by following these simple steps:

* Create the stack in CloudFormation using this link -> https://console.aws.amazon.com/cloudformation/home#/stacks/create/review?templateURL=https://s3.us-east-1.amazonaws.com/sentry-performance-monitoring/cloudformation-template.yaml&stackName=Sentry-Rungutan-ECS
* Fill in the remaining parameters and hit "Create stack"


## Yes, we use it ourselves!

We take great pride in making sure that our platform is as stable and scalable as possible and our monitoring and alerting systems go wild at the tiniest missbehave!

Here's for example our LIVE web platform loading time stats:

<p align="center">
  <img src="https://rungutan.com/img/sentry-live-rungutan-stats.png">
</p>


## Final thoughts

Performance Testing and Performance Monitoring ho hand in hand and none of them must be missing from the toolchain of any good DevOps, Developer or QA.

Choosing the right tooling for your platform is of course difficult, but Rungutan and Sentry have already proven themselves as being production-able and ready for battle!

Don't lose valuable time by guessing why your platform is slow!

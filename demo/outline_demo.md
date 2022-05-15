1. Introduction
    1. Hello everyone! For those of you who don't know me, my name is Cody Myers and I have been working on the Cost Management team for about 2 years now.
    2. Today I am going to be demoing some of the features we have added to Cost Management in 2022.
    3. I am going to start by talking about the work our team has done to support Amazon Web Services Savings Plans. During this demo I am also gonna showcase the 90 day graphs in the cost explorer.
    4. Next I am going to talk about how we now support Google Cloud Platform filted by Openshift.
    5. Then I am going to showcase the new effective usage feature added to our Cost Model.
    6. We are going to start the AWS savings plan demo by going to the cost management settings page.


2. AWS Saving Plans (Use Beta Release) (SWIPE LEFT)
   **Settings**
   1. To get to this page...
   2. At the bottom of this page you will see a section...
    2a. This drop down shows the 3 options for calculating upfront costs: (read em)
   3. For this demo, since I was want to showcase saving plans I am going to stick with amortized. However, more information about the amortized option can be found through the AWS documentation.
   4. By the way any documentation I show during this demo will be in the speaker's notes.
   4. Now lets go take a look at the overview page.

   **Overview Page**
   1. We are going to start on the overview page. From here I can see all of my openshift costs.
   2. However, if we go to infrastructure and change our perspective to Amazon Web Services.
   3. You will see a similar dropdown menu with our preferred cost "Amortized".
    - Which is reflected in the graphs below showing both current and predictive data.
   4. However, notice that if we change our cost type here to blended, the charts are updated to reflect the new cost type.
   5. For example, notice how when we switch from Amortized where the recurrring and/or upfront costs are distributed evenly accross the entire month to blended our cost will go up.
   - That is because those costs are no longer being distributed evenly.
   6. Another area in which you can see this cost type distinction for AWS is the Cost Explorer which is located... (click on it)

   **Cost Explorer**
   1. For anyone unfamiliar with the cost explorer it allows you to create your own custom graphs.
   2. For example, if I want to see my AWS cost grouped by services all I need to do is switch the Perspective to AWS, and the group by to service.
   3. Now this third dropdown should look familiar at this point. I think these graphs can really help understand the difference in the cost views.
    - For example, if we look **Amortized** view notice how the services look consistent each day. However, you can see more fluxuation when I switch the view over to unblended.
   4. Now while we are looking at the Cost Explorer, there is another new feature we added to the cost explorer where customers can now view their the cost data for the last 90 days.
   5. You can do this by selecting the Last 90 days in this dropdown here.
   6. By extending the range of the graphs our custotmers now have a better insight into how their cost fluxuates on the day to day.

3. Return to slide:
    - Now that we have covered the AWS savings plans, and the 90 day graphs in the cost explorer. Lets now take a look at how Cost Management supports Openshift filtered by GCP. We are going to start in the sources page.

4. OCP on GCP
  **Sources:**
    1. Before you can see the cost associated with openshift running on google cloud infrastructure, you will need to have both an openshift and google cloud source setup beforehand.
    2. These sources can be added by going to the settings menu in console.redhat.com, clicking on sources tab in the left navbar, and hitting the add source button.
    3. However, in order to save time, I have already added a GCP source & Openshift source for the purposes of this demo.
    4. More information on how to setup these source can be found in our Documentation.
    5. Now that we have confirmed we have the required sources we can navigate to the overview page in Cost Management.

  **Overview Page:**
    1. We are going to start on the overview page. From here I can see all of my openshift costs.
    2. However, to see our cost of Openshift running on Google Cloud we will need to select the Infrastructure tab at the top and change our Perspective to
    3. Now the only cost I see is Openshift running on Google cloud.
    4. From here we can see our total cost as well as breakdowns for compute, storage, network, and database services.
    5. Also, in this chart to the right we can see our top services, projects, and regions.
    6. We have also added a GCP filted by Openshift option to the cost explorer. (Navigate to cost explorer)

  **Cost Explorer**
    1. As you can see here we now have a Google Cloud Platform filtered by Openshift option in the perspective.
    2. You can create the same kind of custom graphs using the drop down options.
    3. These graphs usually give you some unique inside into your costs.
    4. For example, these graphs really highlight how I added the gcp source for this demo last week. However, its important to know you can now see GCP filtered by Openshift in the Cost Explorer.
    5. With that lets transition over the cost model and segway to the final feature I will demoing today.

6. Effective Usage
  **Cost Model**
    1. For anyone unfamiliar with Cost models, a cost model is a framework used to define the calculations for the costs stored in cost management.
    <!-- #, using raw costs and metrics. (leave out?) -->
    2. What does this mean? Well lets use the cost model I created for the effective cost demo as an example.
    3. As you can see here, I have two metrics (CPU & Memory), in this cost model rates are being assigned to these metrics:
        - For CPU we have a rate of 2
        - For Memory we have a rate of 1
    4. Now the part I want to highlight today is the effective usage which is a new measurement option we have added to our cost model this year.
    5. However, lets take a look a quick look at all of our measurement options because they decide how the rate is applied.
       - By selecting Usage, we can apply our rate to the amount of resources used by the Pod
       - By selecting Requested, we can apply our rate to the amount of resources requested by the Pod.
       - And then we have effective-usage.
    5. The effective usage will take the greater of either usage or request used each hour.
    6. Now I have set up a scenario that is going to help us better understand this, so lets transition over to the openshift details page and see how effective usage is being used to calculate our openshift costs.
  **Openshift Details Page**
    1. We are going to group by project and filter by our cluster.
    2. As you can see here we have two projects, demo_prod & demo stage.
    3. In this scenario I have replicated examples where the projects shown here are using either more or less than the resources they requested from the cluster.
    4. The overall purpose of the effective usage method is to take the max value of the usage or request to calculate the cost.
    5. With this in mind, lets take a look at our demo prod project.
        - As you can see here, the prod project is using more resources than requested for both CPU & Memory.
        - Therefore, the usage amount should be used to calculate our usage cost. We can confirm this by. (show numbers)
    6. Now using the same logic of taking the max value of either the usage or request, lets take a look at our stage project.
       - For this project, the request is higher than our usage values so they will be used to calculate our usage cost.
       - Applying the same logic as last time we see that our expected cost is 3080, which matches our usage cost.
    7. The overall purpose of me showcasing these two project is to highlight how the effective usage method will at a minimum charge for the amount of resources requested like what we saw with demo stage.
    8. However, if the usage exceeds the requested amount like what we saw with the demo prod project, we will use the usage instead to calculate the usage cost.

 7. Return to slide
 This concludes my demo of the new features added to Cost Management in 2022. Feel free to reach out to me with questions, and with that I will give the screen back.

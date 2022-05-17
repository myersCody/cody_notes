1. Introduction
    1. Hello everyone! For those of you who don't know me, my name is Cody Myers and I have been working on the Cost Management team for about 2 years now.
    2. Today I am going to be demoing some of the features we have added to Cost Management in 2022.
    3. I am going to start by talking about the work our team has done to support Amazon Web Services Savings Plans.
    4. During this demo I am also gonna showcase the 90 day graphs in the cost explorer.
    5. Next I am going to talk about how we now support Google Cloud Platform filt'd by Openshift.
    6. Then I am going to showcase effective usage feature within our Cost Model.
    7. By the way any documentation I show during this demo will be down here in the speaker's notes.
    8. With that, lets start the AWS savings plan demo by going to the cost management settings page.

2. AWS Saving Plans (Use Beta Release) (SWIPE LEFT)
   **Settings**
   1. To get to this page... & AT THE BOTTOM OF THIS PAGE:
   2. This drop down shows the 3 options for calculating upfront costs: (read em)
   3. For this demo, since I was want to showcase saving plans I am going to stick with amortized. However, more information about the amortized option can be found through the AWS documentation.
   4. Now lets go take a look at the overview page.

   **Overview Page**
   1. From here I can see all of my openshift costs.
   2. However, if we go to infrastructure and change our perspective to Amazon Web Services.
   3. You will see a similar dropdown menu with our preferred cost "Amortized".
    3. Which is reflected in the graphs below showing both current and predictive data.

   4. If we switch our cost type the page will be updated to reflect the new cost type.
   5. For example, notice how when we switch from Amortized where the recurrring and/or upfront costs are distributed evenly accross the entire month to blended our cost will go up.
   - That is because those costs are no longer being distributed evenly.
   6. Another area in which you can see this cost type distinction for AWS is the Cost Explorer which is located... (click on it)

   **Cost Explorer**
   1. For anyone unfamiliar with the cost explorer it allows you to create your own custom graphs.
   2. For example, if I wanted to see my top services for AWS...
   3. Now this third dropdown should look familiar at this point.
    - I think these graphs can really help you understand the difference in the cost views.
    - For example, if we look **Amortized** view notice how the services look consistent each day. However, you can see more fluxuation when I switch the view over to unblended.
  **90 day** point out this is new
   1. While we are looking at the cost explorer lets focus on another new feature added this year the 90 day graphs. (They can be found in this dropdown here.)
   2. Previously we could only show up to 60 days; however, now we can show up to 90. This option is available for all of our cloud and OCP types.
   3. So you would be able to see a 90 day graph for anything in this dropdown. (use openshift all 90 days)
   3. By extending the range of the graphs our custotmers now have a better insight into how their cost fluxuates on the day to day.

3. Return to slide: (SWIPE RIGHT)
    - Now that we have covered the AWS savings plans, and the 90 day graphs in the cost explorer. Lets now take a look at how Cost Management supports Openshift filtered by GCP. We are going to start in the sources page.

4. OCP on GCP
  **Sources:**
    1. Before you can see the cost associated with openshift running on google cloud infrastructure, you will need to have both an openshift and google cloud source setup beforehand.
    2. You can add sources by clicking the blue button here.
    3. However, in order to save time, I have already added a GCP source & Openshift source for the purposes of this demo.
    4. More information on how to setup these source can be found in our Documentation.
    5. Now that we have confirmed we have the required sources we can navigate to the overview page in Cost Management.

  **Overview Page:** (Navigate to OCP ON GCP)
    1. Now the only cost I see is Openshift running on Google cloud.
    2. From here we can see our total cost as well as breakdowns for compute, storage, network, and database services.
    3. Also, in this chart to the right we can see our top services, projects, and regions.
    4. We have also added a GCP filted by Openshift option to the cost explorer. (Navigate to cost explorer)

  **Cost Explorer**
    1. (CHANGE PERSECPTIVE)
    2. You can create the same kind of custom graphs using the drop down options.
    3. These graphs usually give you some unique insight into your costs.
    4. For example, looking at these graphs you can tell that our openshift & gcp sources were set up last week.
    <!-- these graphs really highlight how I added the gcp source for this demo last week. However, I mostly wanted to point out that GCP filt'd by openshift is now available in the cost explorer. -->
    5. With that lets transition over the cost model and segway to the final feature I will demoing today.

6. Effective Usage
  **Cost Model**
    1. For anyone unfamiliar with Cost models, a cost model is a framework used to define the calculations for the costs stored in cost management using raw costs and metrics.
    2. What does this mean? Well lets use the cost model I created for the effective cost demo as an example.
    3. As you can see here, I have two metrics (CPU & Memory)...

    4. Now the part I want to highlight today is the effective usage which is a new measurement option we have added to our cost model this year.
    5. However, lets take a quick look at all of our measurement options because they decide how the rate is applied.
       - By selecting Usage, we can apply our rate to the amount of resources used by the Pod
       - By selecting Requested, we can apply our rate to the amount of resources requested by the Pod. For clarifiction, this is kind of like when you reserve cores or memory from cluster so others can't use it.
       - And then we have effective-usage.
    5. The effective usage will take the greater of either usage or request used each hour.
    6. Now I have set up a scenario that is going to help us better understand this, so lets transition over to the openshift details page and see how effective usage is being used to calculate our openshift costs.
    7. However, real quick before we transition I want to say that cost models must be assigned to a source for them to be applied. As you can see here I have two sources.
  **Openshift Details Page**
    1. We are going to group by project and filter by our cluster.
    2. As you can see here we have two projects, demo_prod & demo stage.
    3. In this scenario I have replicated examples where the projects shown here are either using more or less than the resources they requested from the cluster.
    4. The overall purpose of the effective usage method is to take the max value of the usage or request to calculate the cost.
    5. With this in mind, lets take a look at our demo prod project.
        - As you can see here, the prod project is using more resources than requested for both CPU & Memory.
        - Therefore, the usage amount should be used to calculate our usage cost. We can confirm this by. (show numbers)
    6. Now using the same logic of taking the max value of either the usage or request, lets take a look at our stage project.
       - For this project, the request is higher than our usage values so they will be used to calculate our usage cost.
       - Applying the same logic as last time we see that our expected cost is 3080, which matches our usage cost.
    7. The overall purpose of me showcasing these two project is to highlight how the effective usage method will at a minimum charge for the amount of resources requested like what we saw with demo stage project.
    8. However, if the usage exceeds the requested amount like what we saw with the demo prod project, we will use the usage instead to calculate the usage cost.
    9. This will help our customers bill for the requested amount at a minimum since its resources the project is claiming from the cluster.

 7. Return to slide
 This concludes my demo of the new features added to Cost Management in 2022. Feel free to reach out to me with questions, and with that I will give the screen back.

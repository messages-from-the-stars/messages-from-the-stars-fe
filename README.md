# Message From The Stars

<img src= "/app/assets/images/satellite_logo.png", alt="Message From The Stars">

## Table of Contents
1. [Overview](#overview)
2. [Location, Location](#location,-location)
3. [Message in a Space Bottle](#message-in-a-space-bottle)
4. [Design & Architexture](#design-&-architexture)
5. [Notes](#notes)
6. [Mock Drafts](#mock-drafts)

## Overview

Have you ever wanted to leave a permanent message in space, like a message in a bottle but sent out to the stars instead of the sea? Ever miss looking out into the skies to see stars and satellites pass along into space?

This application intends to satisfy that desire. Messages From the Stars lets you attach messages directly to satellites that are close to your location. You find a specific satellite from using our Discover Satellites feature and type a message that will be directly connected to that's satellite's coordinates and will follow it along its orbital journey in space. So how does this work exactly?


## Location, Location

Our application is built off of using multiple points of locations to display the interaction happening between 3 primary elements - the user, a satellite (nearby or tracked), and the messages that the user can read or create and attach to a satellites position in space. We utlitize different tools to access and manipulate this data, the primary being 3 APIs - N2YO, Google Maps, & OpenWeather.

The N2YO API is used to track satellite coordinates and plotting their trajectory through orbit. We used 3 different endpoints from them to find information about satellites. These endpoints require different parameters ( latitude, longitude, and altitude ) to let us know where the satellite is in relation to us. Here's a URL template endpoint of a satellites position for example: 

  `https://api.n2yo.com/rest/v1/satellite/positions/{id}/{observer_lat}/{observer_lng}/{observer_alt}/{seconds}`
  
  Here's a template endpoint for the satellites above your location:
  
  `https://api.n2yo.com/rest/v1/satellite/above/{observer_lat}/{observer_lng}/{observer_alt}/{search_radius}/{category_id}`

You would insert your coordinates (latitude, longitude, and altitude ) into the placeholders and would be able to see a stream of data & information that lets you know where that satellite is in relation to you. Utilizing this endpoint as well as the visual passes & satellites above allows us to get information about even more satellites around you.

The Google Maps API is used to visually see on a map where the user, the satellite and a message are at a given point in time. This API call is used to generate an image that gives you the current coordinates of a user, satellite, or a message.

The OpenWeather API is used in tandem with your user location to let you know what days & specific times will be best to view the satellites passing near you.

## Message in a Space Bottle

So where does this tie in to our original application idea? Well this is where our backend comes into play. As a logged in user you can visit our website, click on the "Scan the Skies" button and find satellites within your location. This button is linked to an API call that gets all satellites that meet that criteria and displays them on your current page. After that you can choose a specific satellite that you want to add a message to by clicking on it's hyperlink name. You type in a message ( keep it PG! ) and from there we attach that message to the satellite's current location. That becomes the message's starting position which is tracked by us and is used to tell you how far a message has traveled since you first made it. From there you can repeat the process and keep finding new satellites with messages, track old satellites you had created messages for and see what else has been added since then.

## Design & Architexture 

This side of our application is primarily responsible for the API consumption from the previously mentioned APIs (Google Maps, OpenWeather, N2YO). We initially started with building fixtures ( a way to organize data ) with real data from an actual API call to understand how we are retreiving the data. 
Here's an example of data that you would get from a API call to the satellite positions endpoint that was shown earlier:

  `# https://api.n2yo.com/rest/v1/satellite/positions/(add coordinates) 
   
       "info": {
        "satname": "LAGEOS 2",
        "satid": 22195,
        "transactionscount": 51
    },
    "positions": [
        {
            "satlatitude": -19.59326214,
            "satlongitude": -76.10313081,
            "sataltitude": 5833.65,
            "azimuth": 2.97,
            "elevation": -76.61,
            "ra": 244.50685144,
            "dec": -26.29786845,
            "timestamp": 1663795179,
            "eclipsed": false
        }
    ]
}`


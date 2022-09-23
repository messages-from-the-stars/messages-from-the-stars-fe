   <img src= "/app/assets/images/satellite_logo.png" alt="Messages From The Stars">

# Messages From The Stars

[Home Page](https://messages-from-the-stars.herokuapp.com/ "Messages From The Stars")
[Backend Repository](https://github.com/messages-from-the-stars/messages-from-the-stars-be "Backend Repo")

## Table of Contents
1. [Overview](#overview)
2. [Location, Location](#location,-location)
3. [Message in a Space Bottle](#message-in-a-space-bottle)
4. [Design & Architexture](#design-&-architexture)
5. [Mock Drafts](#mock-drafts)
6. [Notes](#notes)
7. [Resources](#resources)
8. [Contributors](#contributors)


## Overview

Have you ever wanted to leave a message in space, like a letter in a bottle but sent out to the stars instead of the sea? Ever miss looking out into the skies to see stars and satellites pass along into space?

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

We also utilize a geocoder gem that helps us collect a users location thru their IP address. [Further info here](https://github.com/alexreisner/geocoder#readme)

## Message in a Space Bottle

So where does this tie in to our original application idea? Well this is where our backend comes into play. As a logged in user you can visit our website, click on the "Scan the Skies" button and find satellites within your location. This button is linked to an API call that gets all satellites that meet that criteria and displays them on your current page. After that you can choose a specific satellite that you want to add a message to by clicking on it's hyperlink name. You type in a message ( keep it PG! ) and from there we attach that message to the satellite's current location. That becomes the message's starting position which is tracked by us and is used to tell you how far a message has traveled since you first made it. From there you can repeat the process and keep finding new satellites with messages, track old satellites you had created messages for and see what else has been added since then.

## Design & Architexture 

This side of our application is primarily responsible for the API consumption from the previously mentioned APIs (Google Maps, OpenWeather, N2YO). We initially started with building fixtures ( a way to organize data ) with real data from an actual API call to understand how we are retreiving the data. 
Here's an example of data that you would get from a API call to the N2YO satellite positions endpoint that was shown earlier:

  `
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


We take that information and send it through a Service / Facade / Poros pattern. This process returns API json objects from an API call function and turns it into an object more manageable for our application to manipulate. 

Here's an example of what the above call will look like after going through the Service/Facade/Poros pattern:

  `#<SatellitePosition:0x0000000124af21a0 @name="LAGEOS 2", @norad_id=22195, @sat_lat=-19.59326214, @sat_lng=-76.10313081>`

We call upon the attributes in the above saved object inside of html pages that will display the necessary data to our users about their profile, their satellites' and their messages' current location.


## Mock Drafts

Here are the refined mocks we used for our websites design & layout, courtesy of Mike K.

   <img src="/app/assets/images/discover_satellites.png" width="500">
   <img src="/app/assets/images/home_user_dash.png" width="500">
   <img src="/app/assets/images/message_show.png" width="500">
   <img src="/app/assets/images/satellite_show.png" width="500">
   <img src="/app/assets/images/new_message_page.png" width="500">

## Notes

Here are some images of earlier notes Alex B. has made about consuming APIs from N2YO and OpenWeather.

   <img src="/app/assets/images/api_notes_1.png" width="500">
   <img src="/app/assets/images/api_notes_2.png" width="500">

## Resources 

For further resources about any tools / APIs that we utilized, here are some links for the following: 

[Google Map API](https://developers.google.com/maps/get-started "Google Map API Getting Started")

[N2YO API](https://www.n2yo.com/api/ "N2YO API")

[Open Weather Map API](https://openweathermap.org/api "OpenWeatherMap API")

[Geocoder](https://github.com/alexreisner/geocoder#readme "Geocoder Ruby Gem")

## Contributors

[@tig-o](https://github.com/tig-o)
[@philmarcu](https://github.com/philmarcu)
[@mikekoul](https://github.com/mikekoul)
[@alepbloyd](https://github.com/alepbloyd)
[@jonathanmpope](https://github.com/jonathanmpope)



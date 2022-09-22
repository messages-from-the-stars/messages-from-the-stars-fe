# Message From The Stars

## Table of Contents
1. [Example](#example)
2. [Example2](#example2)

## Overview
Have you ever wanted to leave a permanent message in space, like a message in a bottle but sent out to the stars instead of the sea?

This application intends to satisfy that desire. Messages From the Stars lets you attach messages directly to satellites that are close to your location. You find a specific satellite from using our Discover Satellites feature and type a message that will be directly connected to that's satellite's coordinates and will follow it along its orbital journey in space. So how does this work exactly?


## Location, Location
Our application is built off of using multiple points of locations to display the interaction happening between 3 primary elements - the user, a satellite (nearby or tracked), and the messages that the user can read or create and attach to a satellites position in space. We utlitize different tools to access and manipulate this data, the primary being 3 APIs - N2YO, Google Maps, & OpenWeather.

The N2YO API is used to track satellite coordinates and plotting their trajectory through orbit. We used 3 different endpoints from them to find information about satellites. These endpoints require different parameters ( latitude, longitude, and altitude ) to let us know where the satellite is in relation to us. Here's a URL endpoint of a satellites position for example: 

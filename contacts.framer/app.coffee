#author Sergiy Voronov twitter.com/mamezito
# we are importing our assets from sketch
sketch=Framer.Importer.load "imported/framer"

#creating new scroll component
scroll= new ScrollComponent
  width:Screen.width
  height:Screen.height
  scrollHorizontal: false
  #defining top padding in scroll component
  contentInset:
     y:392
#we are putting our sketch contact list into scroll component
sketch.contactList.superLayer=scroll.content

#tabs are created in framer to hold the header stuff
tabs=new Layer
 width:Screen.width
 height:392
 backgroundColor: null
 
 #we are moving sketch header object inside the framer layer "tabs"
sketch.header.superLayer=tabs

#we are defining function to resize our contact cards when scrolling
resizeCards = () ->
	#here we are working with array of layers, we are talking to all sublayers inside our contactList which sits inside scrollcomponent
 	for child in sketch.contactList.subLayers
 		
      		#for each "contact" object in our contact list, we are listening to its absolute Y position, and we are modulating its scale properties based on Y position, so when contact card moves in range 0-400 we are scaling contact card in range 0.8 to 1
      		child.scale=Utils.modulate(child.screenFrame.y,[0,400],[0.8,1],true)
      		#same way we treat with the brightness of the contact card
      		child.brightness=Utils.modulate(child.screenFrame.y,[0,600],[80,100],true)
      		#duplicating previous behaviour when we are moving in other direction, taking into account new range - y positin of contact within the bottom of the page - 1920px-1720 pixels
            		
#we are listening to movement event of the scrollcomponent, and when it moves - we are firing the function of resizing cards using modulate
scroll.on Events.Move, () ->
	
		 resizeCards()

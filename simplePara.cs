using UnityEngine;
using System.Collections;

public class simplePara : MonoBehaviour {

	public float paraScale;  //to adjust speed of parallax effect

	private Vector3 camPos;  //need the camera position so can move the parallax

	//private Vector3 nowPos;	//position of the foreground image, this.object in other words

	private Vector3 bgPos; //getting the background image position so can center parallax on it

	private float tempPos;

	private float mathPos;

	// Use this for initialization
	void Start () {


		//finding the house image to get its position
		var bgImage = GameObject.FindWithTag("houseWide");



		//nowPos = transform.position;


		//get the bg's position so can center the parallax on it
		bgPos = bgImage.transform.position;
	
	}
	
	// Update is called once per frame
	void Update () {


				//need the camera position to parallax correctly
				camPos = Camera.main.transform.position;
				
				//minus the camPos.x from the bgPos.x to create the center '0'
				//then mulitply by -1 to make it opposite direction then slow it down
				//with parascale 
				
				tempPos = ((camPos.x - bgPos.x) * -1) * paraScale;
				
				//another tempvar to clamp the offset between values
				mathPos = (tempPos + bgPos.x);

				mathPos = Mathf.Clamp (mathPos, 20.26f, 23.08f);



				//add the bgpos back in to center the foreground image on the backgroundImage.
				//the y and z are set here by hand but maybe should try it programmatically.
				//it keeps trying to center on the cameraPos when i try it though.
				//transform.position = new Vector3 (tempPos + bgPos.x, -52.27f, -3.5f);
				
				transform.position = new Vector3 (mathPos, -26.58f, -1.3f);

	}
}

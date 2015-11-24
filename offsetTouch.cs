using UnityEngine;
using System.Collections;

public class offsetTouch : MonoBehaviour {
	
	private Vector2 offset;
	
	private float firstTouch;
	
	private float secondTouch;
	
	private Vector2 StartPos;
	
	public float minMovement = 20.0f;
	
	private Vector2 stand;

	private bool isTouching;
	
	
	// Use this for initialization
	void Start () {

		isTouching = false;
		
		offset = GetComponent<Renderer> ().material.mainTextureOffset;
		
	}




	// Update is called once per frame
	void Update () {



		
		foreach (Touch touch in Input.touches) {



			
			var P = touch.position;
			
			if (touch.phase == TouchPhase.Began){

				//Debug.Log (isTouching);


				//below section is to keep the script from reacting to a touch on any part of screen
				//probably is a better way to do that though but i'm not sure what

				Vector3 wp = Camera.main.ScreenToWorldPoint(Input.GetTouch (0).position);
				
				Vector2 touchPos = new Vector2(wp.x, wp.y);

				if (GetComponent<Collider2D>() == Physics2D.OverlapPoint (touchPos)){

					isTouching = true;
				}



				firstTouch = touch.position.x;
				
				StartPos = P;
				
			}
			
			if (touch.phase == TouchPhase.Moved && isTouching){
				
				secondTouch = touch.position.x;
				
				var delta = P - StartPos;
				
				if (delta.magnitude > minMovement){
					
					
					if (secondTouch > firstTouch){
						
						
						if (offset.x < -0.999f){
							
							offset.x = 0.0f;
							//Debug.Log ("offset is " + offset);
							
						} else if (offset.x > -0.999f){
							
							//offset.x = offset.x -= 0.05f * 0.1f;
							//IF IT STOPS WORKING UNCOMMENT THE LINE BELOW AND DELETE THE ONE BELOW THAT. TRYING TO DEAL WITH UNITY WARNING
							//offset.x = offset.x -= 0.5f * 0.01f;
							offset.x -= .10f;// * 0.01f;
							isTouching = false;
							GetComponent<Renderer> ().material.SetTextureOffset ("_MainTex", offset);
							//Debug.Log ("offset is " + offset);
							
						}
						
						
					} else if (secondTouch < firstTouch){
						
						if (offset.x > 0.999f){
							
							offset.x = 0.0f;
							//Debug.Log ("offset is " + offset);
							
						} else if (offset.x < 0.999f){
							
							//offset.x = offset.x += 0.05f * 0.1f;
							//IF IT STOPS WORKING UNCOMMENT THE LINE BELOW AND DELETE THE ONE BELOW THAT. TRYING TO DEAL WITH UNITY WARNING
							//offset.x = offset.x -= 0.5f * 0.01f;
							offset.x += .10f;// * 0.01f;
							isTouching = false;
							GetComponent<Renderer> ().material.SetTextureOffset ("_MainTex", offset);
							//Debug.Log ("offset is " + offset);
							
						}
						
					} 
					
					
					
					//Debug.Log ("offset is " + offset);
					
					
					
				}
				
			} 		if (touch.phase == TouchPhase.Ended) {
				
				isTouching = false;
			
		}


		
		}
		
	}
	
}

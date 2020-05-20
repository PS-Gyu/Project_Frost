using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;


public class CutSceneStreet2 : MonoBehaviour
{
    public PlayableDirector playableDirector;
    public PlayableDirector playableDirector2;
    public TimelineAsset timeline1;
    public TimelineAsset timeline2;

    public GameObject textPanel;

    bool isFirst = true;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    void OnTriggerEnter(Collider other)
    {
        if(other.tag == "Cut Scene")
        {
            if (isFirst)
            {
                playableDirector.Play(timeline1);
                //textPanel.SetActive(false);
                //Destroy(textPanel);
                gameObject.SetActive(false);
                isFirst = false;
            }
            
        }

        if(other.tag == "Cut Scene2")
        {

           
            playableDirector2.Play(timeline2);


            //textPanel.SetActive(false);
            Destroy(gameObject);
            

        }
    }
    private void OnTriggerExit(Collider other)
    {

    }


    // Update is called once per frame
    void Update()
    {
        
    }
}

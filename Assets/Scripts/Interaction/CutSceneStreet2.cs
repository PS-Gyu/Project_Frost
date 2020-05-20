using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;


public class CutSceneStreet2 : MonoBehaviour
{
    public PlayableDirector playableDirector;
    public TimelineAsset timeline;

    public GameObject textPanel;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    void OnTriggerEnter(Collider other)
    {
        if(other.tag == "Cut Scene")
        {
            playableDirector.Play();
            //textPanel.SetActive(false);
            Destroy(textPanel);
            gameObject.SetActive(false);
        }
    }


    // Update is called once per frame
    void Update()
    {
        
    }
}

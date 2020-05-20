﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;


public class CutSceneStreet2 : MonoBehaviour
{
    public PlayableDirector playableDirector;
    public TimelineAsset timeline;

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
                playableDirector.Play();
                //textPanel.SetActive(false);
                Destroy(textPanel);
                gameObject.SetActive(false);
            }
            
        }
    }
    private void OnTriggerExit(Collider other)
    {
        if(other.tag == "Cut Scene")
        {
            isFirst = false;
        }
    }


    // Update is called once per frame
    void Update()
    {
        
    }
}

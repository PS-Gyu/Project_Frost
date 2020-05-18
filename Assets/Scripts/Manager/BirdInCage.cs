using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

public class BirdInCage : MonoBehaviour
{
    DialogueManager theDM;
    ScanMode sm;
    [SerializeField] VolumeProfile dp;
    [SerializeField] VolumeProfile np;

    VolumeProfile pp;

    public bool isInteracted = false;


    // Start is called before the first frame update
    void Start()
    {
        theDM = FindObjectOfType<DialogueManager>();
        sm = FindObjectOfType<ScanMode>();
        //StartCoroutine(darkMuseum());
        pp = dp;

    }

    // Update is called once per frame
    void Update()
    {
        sm.p2 = pp;
        if (GameObject.Find("Museum Volume").GetComponent<Volume>().profile == sm.p1) { }
        else
        {
            GameObject.Find("Museum Volume").GetComponent<Volume>().profile = pp;
        }
    }
}

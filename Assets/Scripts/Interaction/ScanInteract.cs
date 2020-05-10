using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class ScanInteract : MonoBehaviour
{
    void OntriggerEnter(Collider col)
    {
        Debug.Log("Highlighted");
        if (col.gameObject.tag =="SearchingObj")
        {
            col.gameObject.GetComponent<Renderer>().material = col.gameObject.GetComponent<SearchingObj>().highlightMat;
            
        }

    }

    void OntriggerExit(Collider col)
    {
        if (col.tag == "SearchingObj")
        {
            col.gameObject.GetComponent<Renderer>().sharedMaterial = col.gameObject.GetComponent<SearchingObj>().originalMat;
            Debug.Log("Originated");

        }
    }

}

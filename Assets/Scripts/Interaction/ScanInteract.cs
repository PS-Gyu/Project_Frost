using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class ScanInteract : MonoBehaviour
{

    private void OnTriggerEnter(Collider col)
    {
        if (col.tag == "SearchingObj")
        {
            col.GetComponent<Renderer>().material = col.GetComponent<SearchingObj>().highlightMat;
        }
    }

    private void OnTriggerExit(Collider col)
    {
        if(col.tag == "SearchingObj")
        {
            col.GetComponent<Renderer>().material = col.GetComponent<SearchingObj>().originalMat;
        }
    }

}

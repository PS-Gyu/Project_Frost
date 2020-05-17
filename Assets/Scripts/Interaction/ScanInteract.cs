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
            Renderer r = col.GetComponent<Renderer>();
            Material[] mats = r.materials;
            if (r.materials.Length == 1)
            {
                mats[0] = col.GetComponent<SearchingObj>().highlightMat;
                r.materials = mats;
            }
            else
            {
                mats[0] = col.GetComponent<SearchingObj>().highlightMat;
                mats[1] = col.GetComponent<SearchingObj>().highlightMat;
                r.materials = mats;
            }
        }
        else if (col.tag == "USB")
        {
            Renderer r = col.GetComponent<Renderer>();
            Material[] mats = r.materials;
            if (r.materials.Length == 1)
            {
                mats[0] = col.GetComponent<SearchingObj>().highlightMat;
                r.materials = mats;
            }
            else
            {
                mats[0] = col.GetComponent<SearchingObj>().highlightMat;
                mats[1] = col.GetComponent<SearchingObj>().highlightMat;
                r.materials = mats;
            }
        }
        else if (col.tag == "Soldiers")
        {
            Renderer r = col.GetComponent<Renderer>();
            Material[] mats = r.materials;
            if (r.materials.Length == 1)
            {
                mats[0] = col.GetComponent<SearchingObj>().highlightMat;
                r.materials = mats;
            }
            else
            {
                mats[0] = col.GetComponent<SearchingObj>().highlightMat;
                mats[1] = col.GetComponent<SearchingObj>().highlightMat;
                r.materials = mats;
            }
        }
    }

    private void OnTriggerExit(Collider col)
    {
        if (col.tag == "SearchingObj")
        {
            Renderer r = col.GetComponent<Renderer>();
            Material[] mats = r.materials;
            if (r.materials.Length == 1)
            {
                mats[0] = col.GetComponent<SearchingObj>().originalMat1;
                r.materials = mats;
            }
            else
            {
                mats[0] = col.GetComponent<SearchingObj>().originalMat1;
                mats[1] = col.GetComponent<SearchingObj>().originalMat2;
                r.materials = mats;
            }
        }
        else if (col.tag == "USB")
        {
            Renderer r = col.GetComponent<Renderer>();
            Material[] mats = r.materials;
            if (r.materials.Length == 1)
            {
                mats[0] = col.GetComponent<SearchingObj>().originalMat1;
                r.materials = mats;
            }
            else
            {
                mats[0] = col.GetComponent<SearchingObj>().originalMat1;
                mats[1] = col.GetComponent<SearchingObj>().originalMat2;
                r.materials = mats;
            }
        }
        else if (col.tag == "Soldiers")
        {
            Renderer r = col.GetComponent<Renderer>();
            Material[] mats = r.materials;
            if (r.materials.Length == 1)
            {
                mats[0] = col.GetComponent<SearchingObj>().originalMat1;
                r.materials = mats;
            }
            else
            {
                mats[0] = col.GetComponent<SearchingObj>().originalMat1;
                mats[1] = col.GetComponent<SearchingObj>().originalMat2;
                r.materials = mats;
            }
        }
    }

}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UnstableScanInteract : MonoBehaviour
{

    private void OnTriggerEnter(Collider col)
    {
        if (col.CompareTag("Toy"))
        {
            Debug.Log("ToyFound");
            Renderer r = col.GetComponent<Renderer>();
            Material[] mats = r.materials;
            if (r.materials.Length == 1)
            {
                mats[0] = col.GetComponent<SearchingObj>().highlightMat;
                r.materials = mats;
            }
            else {
                mats[0] = col.GetComponent<SearchingObj>().highlightMat;
                mats[1] = col.GetComponent<SearchingObj>().highlightMat;
                r.materials = mats;
            }
            GirlAI.isFound = true;
        }
        if (col.CompareTag("picture"))
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
        if (col.CompareTag("robots"))
        {
            Renderer r = col.GetComponent<SkinnedMeshRenderer>();
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
        if (col.CompareTag("cage"))
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
        if (col.tag == "Toy")
        {
            Renderer r = col.GetComponent<Renderer>();
            Material[] mats = r.materials;
            if (r.materials.Length == 1)
            {
                mats[0] = col.GetComponent<SearchingObj>().originalMat1;
                r.materials = mats;
            }
            else {
                mats[0] = col.GetComponent<SearchingObj>().originalMat1;
                mats[1] = col.GetComponent<SearchingObj>().originalMat2;
                r.materials = mats;
            }
        }
        if (col.tag == "cage")
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
        if (col.tag == "robots")
        {
            Renderer r = col.GetComponent<SkinnedMeshRenderer>();
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
        if (col.tag == "picture")
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

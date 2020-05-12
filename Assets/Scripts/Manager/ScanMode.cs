using Cinemachine;
using Cinemachine.PostFX;
using Invector.vCamera;
using Invector.vCharacterController;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;

public class ScanMode : MonoBehaviour
{
    [SerializeField] GameObject doom;
    [SerializeField] AnimationClip start;
    [SerializeField] AnimationClip end;
    [SerializeField] GameObject pp;
    [SerializeField] VolumeProfile p1;
    [SerializeField] VolumeProfile p2;

    [SerializeField] bool isScan = false;
    [SerializeField] bool isEnd = false;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
        if (!isScan)
        {
            if (!isEnd)
            {
                
                if (Input.GetKeyDown(KeyCode.Tab))
                {
                    isScan = true;
                    StartCoroutine(ScanStart());
                }
            }
        }
        else
        {
            if (isEnd)
            {
                
                if (Input.GetKeyDown(KeyCode.Tab))
                {
                    isScan = false;
                    StartCoroutine(ScanEnd());
                }
            }
        }
    }

    IEnumerator ScanStart()
    {
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().Strafe();
        doom.GetComponent<Animation>().clip = start;
        pp.GetComponent<Volume>().profile = p1;
        doom.GetComponent<Animation>().Play();
        yield return new WaitForSeconds(2.1f);
        isEnd = true;
    }
    IEnumerator ScanEnd()
    {
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().Strafe();
        doom.GetComponent<Animation>().clip = end;
        doom.GetComponent<Animation>().Play();
        yield return new WaitForSeconds(1.0f);
        pp.GetComponent<Volume>().profile = p2;
        yield return new WaitForSeconds(0.1f);
        isEnd = false;
    }

}

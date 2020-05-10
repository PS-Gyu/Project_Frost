using Cinemachine;
using Invector.vCamera;
using Invector.vCharacterController;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScanMode : MonoBehaviour
{
    [SerializeField] GameObject doom;
    [SerializeField] AnimationClip start;
    [SerializeField] AnimationClip end;
    
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
        doom.GetComponent<Animation>().Play();
        yield return new WaitForSeconds(2.1f);
        isEnd = true;
    }
    IEnumerator ScanEnd()
    {
        GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().Strafe();
        doom.GetComponent<Animation>().clip = end;
        doom.GetComponent<Animation>().Play();
        yield return new WaitForSeconds(1.1f);
        isEnd = false;
    }

}

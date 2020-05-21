using Invector.vCharacterController;
using Invector.vCharacterController.vActions;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

public class UnstableScanMode : MonoBehaviour
{
    [SerializeField] GameObject unstableDoom;
    [SerializeField] AnimationClip unstableStart;
    [SerializeField] AnimationClip unstableEnd;
    [SerializeField] GameObject pp;
    [SerializeField] public VolumeProfile p1;
    [SerializeField] public VolumeProfile p2;

    [SerializeField] bool isScan = false;
    [SerializeField] bool isEnd = false;

    bool isUsingLad = false;
    bool isStrafe = false;

    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        isUsingLad = GameObject.FindWithTag("Player").GetComponent<vLadderAction>().isUsingLadder;

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
        else if (isUsingLad && isStrafe)
        {
            GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().Strafe();
            isStrafe = !isStrafe;
        }
        else if (!isUsingLad && isScan && !isStrafe)
        {
            GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().Strafe();
            isStrafe = !isStrafe;
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
        if (isStrafe == false)
        {
            GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().Strafe();
            isStrafe = !isStrafe;
        }
        unstableDoom.GetComponent<Animation>().clip = unstableStart;
        pp.GetComponent<Volume>().profile = p1;
        unstableDoom.GetComponent<Animation>().Play();
        yield return new WaitForSeconds(2.1f);
        isEnd = true;
    }
    IEnumerator ScanEnd()
    {
        if (isStrafe == true)
        {
            GameObject.FindWithTag("Player").GetComponent<vThirdPersonController>().Strafe();
            isStrafe = !isStrafe;
        }
        unstableDoom.GetComponent<Animation>().clip = unstableEnd;
        unstableDoom.GetComponent<Animation>().Play();
        yield return new WaitForSeconds(1.0f);
        pp.GetComponent<Volume>().profile = p2;
        yield return new WaitForSeconds(0.1f);
        isEnd = false;
    }
}

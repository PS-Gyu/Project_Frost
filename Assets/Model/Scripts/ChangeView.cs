using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeView : MonoBehaviour
{
       
    [SerializeField] GameObject vCam0;
    [SerializeField] GameObject vCam1;
    [SerializeField] GameObject vCam2;
    [SerializeField] GameObject vCam3;
    [SerializeField] GameObject vCam4;
    public int WhatsNext;

    void Start()
    {
        WhatsNext = 1;
        Invoke("startScenes", 1);
    }

    // Update is called once per frame
    void Update()
    {
        if(WhatsNext > 0 && WhatsNext < 5)
        {
            if (Input.GetKeyDown(KeyCode.UpArrow) || Input.GetKeyDown(KeyCode.RightArrow))
            {
                WhatsNext += 1;
                SwitchUpdate();
            }

            else if (Input.GetKeyDown(KeyCode.DownArrow) || Input.GetKeyDown(KeyCode.LeftArrow))
            {
                WhatsNext -= 1;
                SwitchUpdate();

            }

        }


    }

    void startScenes()
    {
        vCam1.SetActive(true);
        vCam0.SetActive(false);
    }
    
    void SwitchUpdate()
    {
        switch (WhatsNext)
        {
            case -1:
                vCam1.SetActive(false);
                vCam2.SetActive(false);
                vCam3.SetActive(false);
                vCam4.SetActive(true);
                WhatsNext = 4;
                break;
            case 0:
                vCam1.SetActive(false);
                vCam2.SetActive(false);
                vCam3.SetActive(false);
                vCam4.SetActive(true);
                WhatsNext = 4;
                break;
            case 1:
                vCam1.SetActive(true);
                vCam2.SetActive(false);
                vCam3.SetActive(false);
                vCam4.SetActive(false);
                break;
            case 2:
                vCam1.SetActive(false);
                vCam2.SetActive(true);
                vCam3.SetActive(false);
                vCam4.SetActive(false);
                break;
            case 3:
                vCam1.SetActive(false);
                vCam2.SetActive(false);
                vCam3.SetActive(true);
                vCam4.SetActive(false);
                break;
            case 4:
                vCam1.SetActive(false);
                vCam2.SetActive(false);
                vCam3.SetActive(false);
                vCam4.SetActive(true);
                break;
            case 5:
                vCam1.SetActive(true);
                vCam2.SetActive(false);
                vCam3.SetActive(false);
                vCam4.SetActive(false);
                WhatsNext = 1;
                break;

        }

    }



}

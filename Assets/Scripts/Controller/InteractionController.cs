using Invector.vCharacterController;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InteractionController : MonoBehaviour
{

    [SerializeField] Camera mainCam;
    RaycastHit hitInfo;

    bool isContact = false;
    bool isInteract = false;
    bool isUSB = false;
    bool isPictures = false;
    bool isCage = false;

    DialogueManager theDM;

    void Start()
    {
        theDM = FindObjectOfType<DialogueManager>();
    }

    // Update is called once per frame
    void Update()
    {
        CheckObject();
        ClickLeftBtn();
    }

    void CheckObject()
    {
        int layerMask = 1 << 8;
        layerMask = ~layerMask;
        Vector3 t_MousePos = new Vector3(Input.mousePosition.x, Input.mousePosition.y, Input.mousePosition.z);

        if (Physics.Raycast(mainCam.ScreenPointToRay(t_MousePos), out hitInfo, 10, layerMask))
        {
            Contact();
        }
        else
        {
            NotContact();
        }
    }

    void Contact()
    {
        if (hitInfo.transform.CompareTag("Interaction"))
        {
            if (!isContact)
            {
                isContact = true;
            }
        }
        else if (hitInfo.transform.CompareTag("USB"))
        {
            if (!isUSB)
            {
                isUSB = true;
            }
        }
        else if (hitInfo.transform.CompareTag("cage"))
        {
            if (!isCage)
            {
                isCage = true;
            }
        }
        else { }
    }
    void NotContact()
    {
        if (isContact)
        {
            isContact = false;
        }
        if (isUSB)
        {
            isUSB = false;
        }
        if (isCage)
        {
            isCage = false;
        }
    }



    void ClickLeftBtn()
    {
        if (Input.GetMouseButtonDown(0))
        {
            if (isContact)
            {
                Interact();
            }
            else if (isUSB)
            {
                USB();
            }
            else if (isCage)
            {
                Cage();
            }
            else { }

        }
    }

    void Interact()
    {
        if (hitInfo.transform.GetComponent<InteractionEvent>().isFirst)
        {
            isInteract = true;
            theDM.ShowDialogue(hitInfo.transform.GetComponent<InteractionEvent>().GetDialogue());
            hitInfo.transform.GetComponent<InteractionEvent>().isFirst = false;

        }
    }
    void USB()
    {
        if (!hitInfo.transform.GetComponent<USBnteract>().usbInteracted)
        {
            hitInfo.transform.GetComponent<USBnteract>().usbInteracted = true;
        }
    }
    void Cage()
    {
        if (!hitInfo.transform.GetComponent<CageInteract>().cageInteracted && BirdInCage.isStart)
        {
            hitInfo.transform.GetComponent<CageInteract>().cageInteracted = true;
        }
    }



}

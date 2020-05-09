using Invector.vCharacterController;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InteractionController : MonoBehaviour
{

    [SerializeField] Camera cam;
    RaycastHit hitInfo;

    bool isContact = false;
    bool isInteract = false;

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
        Vector3 t_MousePos = new Vector3(Input.mousePosition.x, Input.mousePosition.y, 0);

        if (Physics.Raycast(cam.ScreenPointToRay(t_MousePos), out hitInfo, 5, layerMask))
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
    }
    void NotContact()
    {
        if (isContact)
        {
            isContact = false;
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
        }
    }

    void Interact()
    {
        if (hitInfo.transform.GetComponent<InteractionEvent>().isFirst)
        {
            isInteract = true;
            theDM.ShowDialogue(hitInfo.transform.GetComponent<InteractionEvent>().GetDialogue());
        }
        hitInfo.transform.GetComponent<InteractionEvent>().isFirst = false;
    }


}

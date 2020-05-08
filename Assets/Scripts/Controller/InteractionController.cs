using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InteractionController : MonoBehaviour
{

    [SerializeField] Camera cam;

    RaycastHit hitInfo;

    bool isContact = false;
    bool isPlaying = false;
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

        if (Physics.Raycast(cam.ScreenPointToRay(t_MousePos), out hitInfo, 3, layerMask))
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

    private void OnCollisionEnter(Collision collision)
    {
        
        if (collision.transform.tag == "Interaction")
        {
            ///'프레스 에프 투 대화' 대화창  .SetActive(true);
            if (Input.GetKeyDown(KeyCode.F))
            {
                if (!isPlaying)
                {
                    Interact();
                }
            }
        }
    }

    void ClickLeftBtn()
    {
        if (Input.GetMouseButtonDown(0))
        {
            if (isContact)
            {
                if (!isPlaying)
                {
                    Interact();
                }
            }
        }
    }

    void Interact()
    {
        isInteract = true;
        
        //인터렉트 후 나올 대화창.SetActive(true);
        theDM.ShowDialogue(hitInfo.transform.GetComponent<InteractionEvent>().GetDialogue());

        //대화창 다 끝나고 isPlaying = false;

        
    }


}

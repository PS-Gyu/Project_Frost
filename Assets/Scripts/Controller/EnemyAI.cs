using Invector.vCharacterController.AI;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using static Invector.vCharacterController.AI.v_AIMotor;

public class EnemyAI : MonoBehaviour
{
    [SerializeField] GameObject goUI;
    public static bool isDetected = false;
    DialogueManager theDM;

    // Start is called before the first frame update
    void Start()
    {
        theDM = FindObjectOfType<DialogueManager>();
        isDetected = false;
    }

    // Update is called once per frame
    void Update()
    {
        if(gameObject.GetComponent<v_AIController>().currentState == AIStates.Chase) {
            StartCoroutine(Detected());
        }
    }

    IEnumerator Detected()
    {
        theDM.EndDialogue();
        yield return new WaitForSeconds(1.0f);
        goUI.SetActive(true);
        yield return new WaitForSeconds(3.0f);
        isDetected = true;
        yield return null;
    }
}

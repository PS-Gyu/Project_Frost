using Invector.vCharacterController.AI;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using static Invector.vCharacterController.AI.v_AIMotor;

public class EnemyAI : MonoBehaviour
{
    [SerializeField] GameObject goUI;
    bool isDetected = false;
    bool isFirst = true;
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        if(gameObject.GetComponent<v_AIController>().currentState == AIStates.Chase) {
            isDetected = true;
        }
        
        if (isDetected && isFirst)
        {
            isFirst = false;
            StartCoroutine(loadSaveFile());
        }
    }

    IEnumerator loadSaveFile()
    {
        yield return new WaitForSeconds(1.0f);
        goUI.SetActive(true);
        yield return null;
    }
}

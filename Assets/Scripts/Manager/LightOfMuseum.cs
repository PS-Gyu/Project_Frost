using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.SceneManagement;

public class LightOfMuseum : MonoBehaviour
{
    [SerializeField] GameObject goUI;
    [SerializeField] GameObject pin;
    DialogueManager theDM;
    bool isRespawned = false;
    bool isSaved = false;
    bool isNowGaming = false;
    Vector3 pos;
    // Start is called before the first frame update
    void Start()
    {
        isNowGaming = false;
        isSaved = false;
        DarkMusFirst.firstDial = false;
        DarkMusSec.secDial = false;
        DarkMusThird.thirdDial = false;
        theDM = FindObjectOfType<DialogueManager>();
        StartCoroutine(lightOffMuseum());
    }

    // Update is called once per frame
    void Update()
    {
        if (EnemyAI.isDetected)
        {
                Destroy(pin);
                SceneManager.LoadScene("008_Dark_Museum_2");
        }
    }


    IEnumerator lightOffMuseum()
    {
        yield return new WaitUntil(() => DarkMusThird.thirdDial);
        gameObject.GetComponent<PlayableDirector>().enabled = true;

        yield return new WaitForSeconds(21.0f);
        Destroy(pin);
        SceneManager.LoadScene(12);

        yield return null;
    }
}

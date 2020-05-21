using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class IntroManager : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(IntroTime());
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    IEnumerator IntroTime()
    {
        yield return new WaitForSeconds(93.11f);
        SceneManager.LoadScene("000_BirdInCage");
    }
}

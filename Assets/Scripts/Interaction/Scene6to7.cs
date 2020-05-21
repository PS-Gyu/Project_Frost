using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Scene6to7 : MonoBehaviour
{
public GameObject pin;

    private void OnEnable()
    {
        SceneManager.LoadScene("007_Street");
        Destroy(pin);
    }
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}


using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BaseFourthDial : MonoBehaviour
{
    public static bool fourthDial = false;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            if (!fourthDial)
            {
                fourthDial = true;
            }

        }
    }
}
